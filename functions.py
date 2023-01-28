# Contains all the extra functions for the main flask framework and handling requests
from datetime import datetime
import data.classes.Assignment as assn

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
