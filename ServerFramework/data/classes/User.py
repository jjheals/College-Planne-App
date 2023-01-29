"""
    User is the only structure that is directly stored 
        Each user has a unique file with their data 
        Each instance of user has an array of Assignments, an array of Exams, and an array of Subjects 
        Each instance of user also has a username, which differentiates user files and data
        
"""
import pickle 
from os import chdir, getcwd
from os.path import isdir, isfile

from data.classes.Subject import Subject
import data.classes.Assignment as a
import functions as func

class User: 
    
    username: str
    assignments: list[a.Assignment] = [] 
    subjects: list[Subject] = []
    
    def __init__(self, username: str):
        self.username = username
        self.assignments = []
        self.subjects = []
        
    # Save this user 
    def save(self, newUser: bool = False):
        print(f"CWD: {getcwd()}")
        pathName = f"./data/users/{self.username}.dat"

        try: 
            with open(pathName, "wb") as f:
                pickle.dump(self, f)
                f.close()
        except Exception as e: 
            print("Error saving user.", e)
      
    # Add a new assignment to this user  
    # Returns 0 on success, 1 on failure
    def addAssignment(self, newAssignment: a.Assignment):
        print("INFO")
        print(self.assignments)
        print(newAssignment.assignmentName)
        self.assignments.append(newAssignment)
        return self.save()
    
    # Adds a new subject to this user 
    # Returns 0 on success, 1 on failure
    def addSubject(self, newSubject: Subject):
        self.subjects = self.subjects.append(newSubject)
        return self.save()
            
    # Get all this user's assignments, sorted by due date
    def userSortAssignments(self):
        tmpAssignment = a.Assignment("","","01/01/2000")
        sortedAssignments = tmpAssignment.sortAssignments(self.assignments)
        return sortedAssignments
   
            
