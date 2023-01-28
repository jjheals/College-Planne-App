"""
    User is the only structure that is directly stored 
        Each user has a unique file with their data 
        Each instance of user has an array of Assignments, an array of Exams, and an array of Subjects 
        Each instance of user also has a username, which differentiates user files and data
        
"""
import pickle 
from os import chdir, getcwd
from os.path import isdir, isfile

from data.classes.Assignment import Assignment 
from data.classes.Exam import Exam
from data.classes.Subject import Subject
from functions import *

class User: 
    
    username: str
    assignments: dict[str:str] 
    subjects: list[Subject]
    exams: list [Exam]
    
    def __init__(self, username: str):
        self.username = username
        self.assignments = []
        self.subjects = []
        self.exams = []
        
    # Save this user 
    # Returns 0 on success, 1 on failure, 2 if user exists

    def save(self, newUser: bool = False):
        pathName = f"../users/{self.username}.dat"

        if isfile(pathName) and newUser:
            print("User already exists")
            return 2
        try: 
            if not isfile(pathName):
                newFile = open(pathName, "x")
                newFile.close()
            with open(pathName, "wb") as f:
                pickle.dump(self, f)
                return 0
        except Exception as e: 
            print("Error saving user.", e)
            return 1
      
      
    # Add a new assignment to this user  
    # Returns 0 on success, 1 on failure
    def addAssignment(self, newAssignment: Assignment):
        self.assignments = self.assignments.append(newAssignment)
        return self.save()
    
    # Adds a new exam to this user 
    # Returns 0 on success, 1 on failure
    def addExam(self, newExam: Exam):
        self.exams = self.exams.append(newExam)
        return self.save()
    
    # Adds a new subject to this user 
    # Returns 0 on success, 1 on failure
    def addSubject(self, newSubject: Subject):
        self.subjects = self.subjects.append(newSubject)
        return self.save()
            
    # Get all this user's assignments, sorted by due date
    def userSortAssignments(self):
        return sortAssignments(self.assignments)
        
            
            
