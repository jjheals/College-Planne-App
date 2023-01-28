from twilio.rest import Client 
 
account_sid = '' # Redacted 
auth_token = '' # Redacted 
client = Client(account_sid, auth_token) 
 
message = client.messages.create( 
                              from_='', # Redacted
                              messaging_service_sid='', # Redacted
                              body='Testing',      
                              to='' # Redacted, static for testing 
                          ) 
 
print(message.sid)
