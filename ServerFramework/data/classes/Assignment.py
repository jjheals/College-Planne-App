from datetime import datetime
import functions as f

class Assignment: 

    assignmenmtName: str 
    forSubject: str 
    dueDate: datetime 
    
    def __init__(self, assignmentName: str, forSubject: str, dueDate: str): 
        self.assignmentName = assignmentName
        self.forSubject = forSubject
        self.dueDate = f.convertDate(dueDate)
        
    # Takes in an array of assignments and sorts them in ascending order by due date, which is comprised of a DAY_OF_YEAR and YEAR
    # Returns a dictionary (for JSON) with key: value -> str: dict[str:str] -> assignmentName: [attributeName: attributeVal]
    # Return ex: {'Homework 1': {'forSubject':}}
    def sortAssignments(self, assignments):
        assignmentDict = { } 
        
        for a in assignments: 
            assignmentDict[a] = a.dueDate
        
        sortedAssignments: list[Assignment] = sorted(assignmentDict.items(), key=lambda kv: kv[1], reverse=True)
        print(f"SORTED ASSIGNMENTS {sortedAssignments}")
        finalAssignmentDict: dict[str:dict[str:str]] = { } 
        
        # Creating the value dictionary (inner dictionary)
        for a in sortedAssignments:
            theseAttributes: dict[str:str] = {'for-subject': '', 'due-date':''}
            theseAttributes['for-subject'] = a[0].forSubject
            theseAttributes['due-date'] = a[1].strftime(f'%a %b %-d') # Format "Sun Jan 6"
            
            # Add these attributes to this assignment in finalAssignments
            finalAssignmentDict[a[0].assignmentName] = theseAttributes
        
        return finalAssignmentDict    
        
        
