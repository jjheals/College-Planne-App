# Assignment.py
#
#
# Contains the definition for the Assignment custom data type
#
#
# An assignment has:
#       assignmentName: str -> the assignment's name
#       forSubject: str -> the subjet the assignment is associated with. Subject name is a primary key of Subject, so it is inherited by Assignment 
#                          in the many-to-one relationship
#       dueDate: datetime -> the date the assignment is due on. Same as with forSubject, it is a many-to-one relationship b/w Assignment and a Date
#
#



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
    def sortAssignments(self, assignments, subj=""): 

        # Translate the list into correct dict format 
        finalAssignmentDict: dict[str:dict[str:str]] = { } 
        
        # Adds a valid assignment to finalAssignmentDict
        def validAssignment(assn):
            theseAttributes: dict[str:str] = {'for-subject':'', 'due-date':''}
            theseAttributes['for-subject'] = assn.forSubject
            theseAttributes['due-date'] = assn.dueDate.strftime(f'%a %b %-d') # Format "Sun Jan 6"
            finalAssignmentDict[assn.assignmentName] = theseAttributes
    
        # Creating the value dictionary (inner dictionary)
        if subj: 
            print("RESTRICTING TO SUBJECT {subj}")
            for a in assignments:
                if a.forSubject == subj: 
                 validAssignment(a)
                 print(f"VALID ASSIGNMENT {a.assignmentName} FOR {a.forSubject}")
        else: 
            print("NO SUBJECT RESTRICTION")
            for a in assignments:
                validAssignment(a)
                print(f"VALID ASSIGNMENT {a.assignmentName} FOR {a.forSubject}")
        # Results
        print(finalAssignmentDict)
        return finalAssignmentDict    
        
        
