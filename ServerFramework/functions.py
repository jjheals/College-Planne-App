# functions.py 
#
# Contains some of the extra functions for the main flask framework and handling requests
# 

from datetime import datetime
import data.classes.Assignment as assn

# Returns a datetime object 
# date must be given in mm-dd-yyyy format
def convertDate(date: str): 
    print(f"DATE {date}")
    # date is given in mm-dd-yyyy
    mm = int(date[0]+date[1])
    dd = int(date[3]+date[4])
    yyyy = int(date[6]+date[7]+date[8]+date[9])
    
    # Convert the month, day, and year into dayOfYear and year
    dateObj = datetime(yyyy, mm, dd)
    return dateObj 
    
