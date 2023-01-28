# Contains all the extra functions for the main flask framework and handling requests
from datetime import datetime
from data.classes.Assignment import Assignment

# Returns a datetime object 
# date must be given in mm-dd-yyyy format
def convertDate(date: str): 
    
    # date is given in mm-dd-yyyy
    dateArray = date.split()
    mm = int(date[:2])
    dd = int(dateArray[3]+dateArray[4])
    yyyy = int(date[4:])
    
    # Convert the month, day, and year into dayOfYear and year
    dateObj = datetime(yyyy, mm, dd)
    return dateObj
    
    
    
# Takes in an array of assignments and sorts them in ascending order by due date, which is comprised of a DAY_OF_YEAR and YEAR
# Returns a dictionary (for JSON) with key: value -> str: dict[str:str] -> assignmentName: [attributeName: attributeVal]
# Return ex: {'Homework 1': {'forSubject':}}
def sortAssignments(assignments: list[Assignment]):
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
        
