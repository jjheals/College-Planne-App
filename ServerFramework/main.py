# main.py
#
# Main application API
#
# NOTE: with time constrains, security was hard to implement. We had issues implementing Auth0 and ran out of time to debug, so we scrapped that
#       from the backend. The frontend, however, does still use Auth0 to authenticate users and sign them in. Their username, a unique ID, is sent
#       to all API calls. The username identifies the user and allows them to access his or her data.
#       
#       The problem with this is that with a username one could (in theory) create HTTP requests to the server and query any user's data without
#       any authentication. This is where we would have liked to implement Auth0 server-side, but we simply ran out of time. We plan to continue 
#       developing this app, so that will likely be a version 2.0 feature.
#
#       The code in this file (and others) could be cleaner or more efficient in some areas. We aimed for functionality first, then writing pretty
#       code. We had a lot of trouble with Twilio's API but were able to debug and get it to work in the end.
#
#       ENDPOINTS:
#           /add-phone adds a phone number to a user specified in the body of the request
#           /get-assignments returns a json body of a user's assignments, optionally sorted by subject
#           /add-assignment adds an assignment to the specified user 
#           /add-subject adds a subject to the specified user
#           /get-subjects returns a json body of all the subjects for the specified user
#           /verify verifies that a user exists, or attempts to create a new user if the user does not exist 
#           /force-notifs was used for testing purposes. It bypasses the time delay on sending assignment notifications by calling findDueAssignments 
#                         directly and not through sendSMS
#




from urllib import request
from flask import Flask, json, jsonify
from flask import request
from gevent.pywsgi import WSGIServer
from flask_compress import Compress

from os import chdir, getcwd, listdir   
from os.path import isfile

import data.classes.User as u
import data.classes.Assignment as assgn
import pickle
from threading import Thread

# For SMS
import schedule, time
from SwiftSMS.Alert import Alert
import datetime


app = Flask(__name__)

compress = Compress()
compress.init_app(app)

# -------------------------------------#
# Add a phone number 
@app.route('/add-phone', methods=["POST"])
def addPhone():
    thisUsername = request.json['username']
    pathName = getRequestInfo(request)

    # Check if user actually exists
    if not checkUserExists(pathName):
        print(f"User {thisUsername} does not exist")
        return formatResponse(thisUsername, 'failure', 'User does not exist')

    # Add phone 
    with open(pathName, 'rb') as f:
        thisUser = pickle.load(f)

    thisUser.addPhone(request.json['phone'])
    thisUser.save()
    print(f"Added new phone number {request.json['phone']} for User {thisUsername}")
    return formatResponse(thisUsername, 'success', '')

# -------------------------------------#
# Verify a new phone number
@app.route('/force-notifs', methods=['POST'])
def forceNotifs():
    findDueAssignments()
    return formatResponse(request.json['username'], 'success', '') 

# -------------------------------------#
# Get all the assignments for a particular user (sorted by date) 
# Call with JSON containing at LEAST:
#   { "username": string }
@app.route('/get-assignments', methods = ["POST"])
def getAssignments():
    
    thisUsername = request.json['username']
    pathName = getRequestInfo(request)

    # Check if user actually exists
    if not checkUserExists(pathName): 
        print(f"User {thisUsername} does not exist.")
        return formatResponse(thisUsername, 'failure', 'User does not exist')

    # IF request contains key "Subject"
    #   -> Filter assignments to that subject
    jsonRequest = request.json
    
    with open(pathName, "rb") as f:
        user: u.User = pickle.load(f)
    if jsonRequest["for-subject"] != "": 
        subj = jsonRequest["for-subject"]
        theseAssignments: dict[str:dict[str:str]] = user.userSortAssignments(subj)
    else: 
        theseAssignments: dict[str:dict[str:str]] = user.userSortAssignments()
    
    return jsonify(theseAssignments)

# -------------------------------------#
# Add an assignment to a user 
# Call with JSON containing at LEAST: 
#   { "username": string, "assignment-name": string, 
#     "for-subject": string,} 
@app.route('/add-assignment', methods = ["POST"])
def addAssignment(): 
    
    # Get this path name to check and save infp
    pathName = getRequestInfo(request)
    # Check if user actually exists; return an error message if not
    if not checkUserExists(pathName): return formatResponse(request.json["username"], "failure", "User does not exist.")
    # If the user exists, load the user
    with open(pathName, "rb") as f: 
        thisUser = pickle.load(f)
        
    # Create the assignment 
    jsonData = request.json
    username = jsonData["username"]
    name = jsonData["assignment-name"]
    forSubj = jsonData["for-subject"]
    dueDate = jsonData["due-date"]
    # Create the new assignment
    newAssignment = assgn.Assignment(name, forSubj, dueDate)
    # Add this assignment to this user 
    thisUser.addAssignment(newAssignment)
    # Save this user's new state
    thisUser.save()
    # Return 
    return formatResponse(username, "success", "")


# -------------------------------------#
@app.route('/add-subject', methods=["POST"])
def addSubject():
    
    # Get the path name 
    pathName = getRequestInfo(request)
    # Check if user actually exists
    if not checkUserExists(pathName): return formatResponse("NONE", "failure", "User does not exist.")
    # If the user exists, load the user
    with open(pathName, "rb") as f:
        thisUser = pickle.load(f)

    # Add the subject to this user 
    thisUser.addSubject(request.json['subject-name'])
    thisUser.save()
    # Return 
    return formatResponse(request.json['username'], "success", "")



# -------------------------------------#
@app.route('/get-subjets', methods=["POST"])
def getSubjects():

    pathName = getRequestInfo(request)

    # Check if user actually exists
    if not checkUserExists(pathName): return formatResponse("NONE", "failure", "User does not exist.")
    # Load user 
    with open(pathName, "rb") as f:
        thisUser = pickle.load(f)
    # Get subjects
    print(f"Getting all subjects for {request.json['username']}")
    # Subjects is a dictionary with keys of just numbers as strings ("1", "2", ...) and subject names as values
    subjects = thisUser.getSubjects()

    return jsonify(subjects)
    # Load user 


# -------------------------------------#
@app.route('/verify', methods=["POST"])
def verifyUser():
    thisUsername = request.json["username"]
    pathName = getRequestInfo(request)
    status: str

    print(f"Verifying user {thisUsername}")
    print(f"Path: {pathName}")

    # Check if this user actually exists
    # Return a status of "success" if successful, a status of "failure" if not 
    if checkUserExists(pathName): 
        status = "success"
        print(f"Success. Found user {thisUsername}.")
    else: 
        # Try to create a user
        print(f"User {thisUsername} does not exist. Trying to create a new user ...")
        newUser = u.User(thisUsername)
        newUser.save(newUser = True)
        print(f"Created new user {thisUsername}")
        status = "success" # User created

    response = formatResponse(thisUsername, "success", "")

    print(response)
    return response


# ------------------------------ #

def getRequestInfo(req: request):
    data = request.json
    print(data)
    thisUser = data["username"]
    pathName = f'data/users/{thisUser}.dat'
    print(f"Working directory: {getcwd()}")
    
    return pathName
    

def checkUserExists(pathName: str): 
    return isfile(pathName)
    

def formatResponse(username: str, status: str, error: str): 
    response = {"username": username, 
                "status": status,
                "error": error}
    return jsonify(response)


# ------------------------------ #

def run():
    http_server = WSGIServer(('0.0.0.0', 8080), app)
    http_server.serve_forever()
        

def findDueAssignments():

    # Local Helper
    def isTomorrow(date: datetime):
        today = datetime.datetime.now()
        tomorrow = today + datetime.timedelta(days=1)
        return date.date() == tomorrow.date()

    # For EVERY USER
    for f in listdir("./data/users/"):
        # Load this user
        thisFile = open(f"./data/users/{f}", "rb")
        thisUser = pickle.load(thisFile)
        # Get this user's assignments
        allAssignments = thisUser.assignments
        dueTomorrow = []
        print(allAssignments)
        # Find assignments that are due tomorrow
        for a in allAssignments:
            print(a.assignmentName)
            print(a.dueDate)
            if isTomorrow(a.dueDate):
                dueTomorrow.append(a.forSubject + ": " + a.assignmentName)
        # Console log
        print(f"User {thisUser.username} has {len(dueTomorrow)} assignments due tomorrow. Sending a text ...")
        # Format message
        if not dueTomorrow: message = f"Hey {thisUser.username}! Take a day off - nothing is due tomorrow!"
        else: message = f"Hey {thisUser.username}! Don't forget, you have {len(dueTomorrow)} assignments due tomorrow: "
        # Append a list of due assignments to the message
        for a in dueTomorrow: message += a + ", "
        # Send the sms
        sendSMS(thisUser.phone, message)
    
def sendSMS(number, msg): 
    newAlert = Alert(number, msg)
    newAlert.sendAlert()

# Sends SMS alerts every day at 10:00
def runScheduledTask():
    schedule.every().day.at("10:00").do(task)
    while True:
        schedule.run_pending()
        time.sleep(1)


if __name__ == '__main__':
    
    t1 = Thread(target=run())
    
    http_server = WSGIServer(('0.0.0.0', 8080), app)
    http_server.serve_forever()
    # TEST OBJECTS
    
    
