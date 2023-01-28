from datetime import datetime

class Assignment: 

    assignmenmtName: str 
    forSubject: str 
    dueDate: datetime 
    completed: bool
    
    def __init__(self, assignmentName: str, forSubject: str, dueDate: str): 
        self.assignmentName = assignmentName
        self.forSubject = forSubject
        self.dueDate = f.convertDate(dueDate)
        self.completed = False
        
   # Takes in an array of assignments and sorts them in ascending order by due date, which is comprised of a DAY_OF_YEAR and YEAR
    # Returns a dictionary (for JSON) with key: value -> str: dict[str:str] -> assignmentName: [attributeName: attributeVal]
    # Return ex: {'Homework 1': {'forSubject':}}
    def sortAssignments(assignments):
        assignmentDict = { } 
        
        for a in assignments: 
            assignmentDict[a] = a.dueDate
        
        sortedAssignments: list[Assignment] = sorted(a.items(), key=lambda kv: kv[1])
        
        finalAssignmentDict: dict[str:dict[str:str]] = { } 
        
        # Creating the value dictionary (inner dictionary)
        for a in sortedAssignments:
            theseAttributes: dict[str:str] = { }
            theseAttributes['for-subject'] = a.forSubject
            theseAttributes['due-date'] = a.dueDate.strftime(f'%a %b %-d') # Format "Sun Jan 6"
            theseAttributes['completed'] = str(a.completed)
            
            # Add these attributes to this assignment in finalAssignments
            finalAssignmentDict[a.assignmentName] = theseAttributes
        
        return finalAssignmentDict    
        
        
