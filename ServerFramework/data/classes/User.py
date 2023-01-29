# User.py
#
#
#
#   User is the only structure that is directly stored 
#        Each user has a unique file with their data 
#        Each instance of user has an array of Assignments, a username (unique), phone number, verified status, and an array of Subjects 
#        Each instance of user also has a username, which differentiates user files and data
#        

import pickle 
from os import chdir, getcwd
from os.path import isdir, isfile

import data.classes.Assignment as a
import functions as func

class User: 
    
    username: str
    phone: str
    phoneVerified: bool
    assignments: list[a.Assignment] = [] 
    subjects: list[str] = []
    
    def __init__(self, username: str):
        self.username = username
        self.phone = '0000000000'
        self.phoneVerified = False
        self.assignments = []
        self.subjects = []
    
    # Set a user's phone number
    def addPhone(self, newPhone: int):
        self.phone = newPhone
        self.save()
        print(f"NEW PHONE NUMBER ADDED FOR {self.username}")

    # Save this user 
    def save(self, newUser: bool = False):
        print(f"SAVING {self.username}")
        pathName = f"./data/users/{self.username}.dat"

        try: 
            with open(pathName, "wb") as f:
                pickle.dump(self, f)
                f.close()
        except Exception as e: 
            print("Error saving user.", e)
      
    # Add a new assignment to this user  
    def addAssignment(self, newAssignment: a.Assignment):
        print(f"SAVING NEW ASSIGNMENT FOR {self.username}")
        self.assignments.append(newAssignment)
        self.save()
        print(f"Successfully saved new assignment {newAssignment.assignmentName} for user {self.username}")
        
    # Adds a new subject to this user
    def addSubject(self, newSubject: str):
        print(f"SAVING NEW SUBJECT FOR {self.username}")
        if not newSubject in self.subjects: self.subjects.append(newSubject)
        else: print(f"Subject {newSubject} already exists for user {self.username}. Continuing with request as normal.")
        self.save()
        print(f"Successfully saved new subject {newSubject} for user {self.username}")
            
    # Get all this user's assignments
    # NOTE: must be sorted by date client-side because dictionaries are inherently unordered
    def userSortAssignments(self, subj=""):
        tmpAssignment = a.Assignment("","","01/01/2000")
        if subj: sortedAssignments = tmpAssignment.sortAssignments(self.assignments, subj)
        else: sortedAssignments = tmpAssignment.sortAssignments(self.assignments)
        return sortedAssignments
   
            
