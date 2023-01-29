# Alert.py
#
# Contains the Alert class
#
#
# The Alert class is used to send an SMS message to a specified phone number with a specified message. It is called in main.py through sendSMS
#
#


from twilio.rest import Client 

class Alert:
    
    # Credentials
    # NOTE: storing in env variables is more secure but this was for testing purposes only
    accountSID = 'ACa6acd5e112dd01c696b4535e8737a1b9' # Redacted 
    authToken = '6a944ad16d8021fed62d060c4960d8d6' # Redacted 
    messageSID = 'MGd985d37adb1436dab1829cf15dd8329b'
    fromNumber = '+184444361861'
    client = Client(accountSID, authToken)
    sendToNumber: str
    alert: str
    
    def __init__(self, sendToNumber: str, alert):
        self.sendToNumber = sendToNumber
        self.alert = alert
    
    # Send an alert to a user
    # Uses the variables in self to specify configurations
    def sendAlert(self):
        message = self.client.messages.create(from_='+16402238774',
                                         messaging_service_sid = self.messageSID,
                                         body = self.alert,      
                                         to = self.sendToNumber) # Static for testing 
        # Console log
        print(f"Message SID: {message.sid}\nAlerted {self.sendToNumber}: {self.alert}")
