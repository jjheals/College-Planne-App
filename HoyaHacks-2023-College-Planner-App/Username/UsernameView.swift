//
//  UsernameView.swift
//  HoyaHacks-2023-College-Planner-App
//
//  Created by Anay Gandhi on 1/27/23.
//
 
import SwiftUI

public class username: ObservableObject {
    @Published var user: String = ""
}

struct UsernameView: View {
    @State private var enteredUser: String = ""
//var to dictate whether the keyboard is brought up or not
    @FocusState private var isFocused: Bool
    
    var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.blue)
                    .frame(width: 200, height: 100)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .frame(width: 180, height: 80)
                VStack (alignment: .center, spacing: 15) {
                    TextField("Enter a username", text: $enteredUser)
                        .multilineTextAlignment(.center)
                    //sets boolean $isFocused to true when keyboard is pulled up
                        .focused($isFocused)
                    Button(action: {
                        // Create new network
                        var thisNetwork: Network = Network()
                        // Verify this user
                        thisNetwork.verifyUser(username: enteredUser)
                        var verified: Bool = thisNetwork.thisUser?.verified != nil // If thisNetwork.thisUser is verified
                        
                        /* DO SOMETHING */
                        if verified {
                            // User verified //
                            // Add MFA? //
                            
                        } else {
                            // User not verified, create a new user
                            var newUser: User {
                                do {
                                    // Create a new user
                                    try thisNetwork.createUser(username: enteredUser)
                                } catch {
                                    // If an error, make thisNetwork.thisUser an unverified user
                                    let notVerifiedUser = User(username: "", verified: false)
                                    thisNetwork.thisUser = notVerifiedUser
                                }
                                // Return thisNetwork.thisUser
                                // Call "newUser.verified"
                                return thisNetwork.thisUser!
                            }
                            // Check if newUser executed without issues
                            /* DO SOMETHING */
                            if newUser.verified! {
                                // New user verified //
                            
                            /* DO SOMETHING */
                            } else {
                                // Error creating a new user

                            }
                        }
                    //sets boolean to false, removing the keyboard
                        isFocused = false
                        
                        }, label: {
                            Text("Enter")
                        }
                    )
                }
            }
    }
}


struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}
