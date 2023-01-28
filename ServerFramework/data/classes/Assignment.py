from datetime import datetime
from functions import convertDate

class Assignment: 

    assignmenmtName: str 
    forSubject: str 
    dueDate: datetime 
    completed: bool
    
    def __init__(self, assignmentName: str, forSubject: str, dueDate: str): 
        self.assignmentName = assignmentName
        self.forSubject = forSubject
        self.dueDate = convertDate(dueDate)
        self.completed = False
        
    
        
        