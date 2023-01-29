from urllib import request
from flask import Flask, json, jsonify
from flask import request
from gevent.pywsgi import WSGIServer
from flask_compress import Compress

from os import chdir, getcwd
from os.path import isfile

import data.classes.User as u
import data.classes.Assignment as assgn
import pickle

app = Flask(__name__)

compress = Compress()
compress.init_app(app)


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
        return jsonify({'status': 'Error: User does not exist'})

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
    if not checkUserExists(pathName): return formatResponse("NONE", "failure", "User does not exist.")
    # If the user exists, load the user
    print(getcwd())
    print(pathName)
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


if __name__ == '__main__':
    http_server = WSGIServer(('0.0.0.0', 8080), app)
    http_server.serve_forever()
    
    # TEST OBJECTS
    
    
