# VerificationHandler.py
#
#
# ** This class is not actually used (yet) in the application. We created it when we were trying to send SMS verification messages to users but ran
#    out of time to implement it fully, so we scrapped the implementation but kept the code for future use 
#
# NOTE: When this class is deployed, we plan to add an event handler to take in responses from the Twilio API about the status of requests. The Twilio
#       API would send a message to a dedicated endpoint, then VerificationHandler instances could be updated accordingly
#
#

import requests
from twilio.rest import Client

class VerificationHandler: 
    secret:str
    accountSID:str
    authToken:str
    messageSID:str
    phoneNumber:str

    def __init__(self, phoneNumber: str):
        self.secret = ''
        self.accountSID = ''
        self.authToken = ''
        self.messageSID = ''
        self.phoneNumber = "+1"+phoneNumber 


    def sendVerification(self):
        endpoint = f"https://verify.twilio.com/v2/Services/{self.messageSID}/Verifications"
        print(f"SENDING VERIFICATION TO {self.phoneNumber}")
        payload = {"To": "+19784040691", "Channel": "sms"}
        response = requests.post(endpoint, auth=(self.accountSID, self.authToken), data=payload)

        if response.status_code == 201:
            print("Verification request sent to", self.phoneNumber)
            return True
        else:
            print("An error occurred while sending the verification request:", response.text)
            return False

             
    # Check if this instance was verified 
    # Maybe change to be defined in the main app file?
    def checkVerification(self):
        # Verify the phone number
        verificationCheck = self.client.verify.v2.services(VerificationHandler.accountSID).verification_checks.create(to=self.phoneNumber, code=code)

        # Check if the verification was successful
        if verificationCheck.status == 'approved':
            print(f'Phone number {self.phoneNumber} has been verified.')
            self.notifyUser(True)
            return True
        else:
            print(f'Verification for {self.phoneNumber} failed')
            self.notifyUser(False)
            return False

    # Notify the user if their code was verified 
    def notifyUser(self, verified: bool):
        if verified: msgBody = 'Your phone number has been verified!'
        else: 'Verification failed.'

        message = self.client.messages.create(
            body = msgBody,
            from_ = '+18444361861',
            to = self.phoneNumber)

