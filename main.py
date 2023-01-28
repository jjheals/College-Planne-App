from urllib import request
from flask import Flask, json, Response
from flask import request
from gevent.pywsgi import WSGIServer
from flask_compress import Compress

from os import chdir
from os.path import isfile

from data.classes.User import User
from data.classes.Assignment import Assignment

import pickle 
from functions import *

chdir('./data/classes')
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
    data, thisUser, pathName = getRequestInfo(request)

    if checkUserExists(pathName):
        return {'Error': 'User already exists'}
    else: 
        # Create a new user
        User(thisUser).save()
        return {"Success":f"Created user {data['username']}"}

# -------------------------------------#
# Get all the assignments for a particular user (sorted by date) 
# Call with JSON containing at LEAST:
#   { "username": string }
@app.route('/get-assignments', methods = ["POST"])
def getAssignments():
    
    data, thisUser, pathName = getRequestInfo(request)

    # Check if user actually exists
    if not checkUserExists(pathName): return json.dumps({'Error': 'User does not exist'})

    with open(pathName, "r") as f: 
        user: User = pickle.load(f)
        f.close()
    
    theseAssignments: dict[str:dict[str: str]] = user.userSortAssignments()
    
    return json.dumps(theseAssignments)

# -------------------------------------#
# Add an assignment to a user 
# Call with JSON containing at LEAST: 
#   { "username": string, "assignment-name": string } 
@app.route('/add-assignment', methods = ["POST"])
def addAssignment(): 
    
    data, thisUser, pathName = getRequestInfo(request)
    
    if not checkUserExists(): return json.dump(userDNEErrorMessage)
    
    #### DO MORE

# -------------------------------------#
@app.route('/verify', methods=["POST"])
def verifyUser():
    data, thisUser, pathName = getRequestInfo(request)
    
    if checkUserExists(pathName): 
        return Response(status=200)
    else: 
        return Response(status=404)
    
# ------------------------------ #
def getRequestInfo(req: request):
    data = request.json
    thisUser = data['username']
    pathName = f'../data/users/{thisUser}.dat'
    
    return data, thisUser, pathName
    

def checkUserExists(pathName: str): 
    return isfile(pathName)
    
# ------------------------------ #


if __name__ == '__main__':
    http_server = WSGIServer(('0.0.0.0', 8080), app)
    http_server.serve_forever()
    
    # TEST OBJECTS
    
    
