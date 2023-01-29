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
    @State private var isButtonVisible = true
    
//    var testUsername: String = " "
    
//    init(testUsername1: String) {
//        self.testUsername = testUsername1
//        print(testUsername1 + " <-----")
//    }
//
//    init() {}
    
    var body: some View {
        if isButtonVisible {
            ZStack {
                VStack (alignment: .center, spacing: 15) {
                    TextField("Enter a username", text: $enteredUser)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.black)

                    //sets boolean $isFocused to true when keyboard is pulled up
                        .focused($isFocused)
                    
                    
                        Button(action: {
                            print("ENTERED USERNAME: \(enteredUser)")
                            // Create new network
                            let postReq = APIRequest(endpoint: "/verify")
                            postReq.verifyUser(enteredUser, completion: { result in
                                switch result {
                                case .success(let message):
                                    print(message)
                                    print("Success")
                                    self.isButtonVisible = false
                                    newView(name: enteredUser)
//                                    UsernameView(testUsername1: enteredUser)
                                case .failure(let error):
                                    print(result)
                                    print("Error", error)
                                    UsernameView()
                                }
                            })
                            isFocused = false
                        }, label: {
                            Capsule().overlay (
                                Text("Enter")
                                    .foregroundColor(.black)
                                    .padding()
                            ).frame (width: 100, height: 40)
                        }
                        )
                    }
                }.modifier(CustomViewModifier(roundedCornes: 6, startColor: .blue, endColor: .purple, textColor: .white))
        }
    }
}


struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
//        UsernameView(testUsername1: "")
        UsernameView()
    }
}

struct newView: View {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        VStack{
            Text("Hello, \(self.name)")
        }
    }
}
