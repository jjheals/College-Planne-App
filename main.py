from urllib import request
from flask import Flask, json, jsonify
from flask import request
from gevent.pywsgi import WSGIServer
from flask_compress import Compress

from os import chdir, getcwd
from os.path import isfile

import data.classes.User as u

import pickle

app = Flask(__name__)

compress = Compress()
compress.init_app(app)

# GLOBAL VARS
userDNEErrorMessage: dict[str:str] = {'Error': 'User does not exist.'}

# -------------------------------------#
# Create a new year
# Call with JSON containing at LEAST: 
#   { "username": string }
@app.route('/create-user', methods=["POST"])
def createUser():
    
    # Get the data from the POST request
    pathName = getRequestInfo(request)

    if checkUserExists(pathName):
        return {'Error': 'User already exists'}
    else: 
        # Create a new user
        u.User(request.json["username"]).save()
        return jsonify({"username": request.json["username"],
                        "status":f"Success. Created user {request.json['username']}"})

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

    try: 
        subj = jsonRequest["Subject"]
    except: 
        subj = ""

    with open(pathName, "r") as f: 
        user: u.User = pickle.load(f)
        f.close()
    
    theseAssignments: dict[str:dict[str: str]] = user.userSortAssignments(subj)
    
    return jsonify(theseAssignments)

# -------------------------------------#
# Add an assignment to a user 
# Call with JSON containing at LEAST: 
#   { "username": string, "assignment-name": string } 
@app.route('/add-assignment', methods = ["POST"])
def addAssignment(): 
    
    pathName = getRequestInfo(request)
    
    if not checkUserExists(): return jsonify(userDNEErrorMessage)
    
    #### DO MORE

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

    response = {"username": thisUsername,
                "status": "success"}
    print(response)
    return jsonify(response)
        
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
    
# ------------------------------ #


if __name__ == '__main__':
    http_server = WSGIServer(('0.0.0.0', 8080), app)
    http_server.serve_forever()
    
    # TEST OBJECTS
    
    
