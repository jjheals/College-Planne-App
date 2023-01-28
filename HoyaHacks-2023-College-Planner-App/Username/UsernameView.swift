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
    @FocusState private var isFocused: Bool         //var to dictate whether the keyboard is brought up or not
    @State private var running: Int = 2                // 1 == verified ; 0 == not verified
    
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
                        .textFieldStyle(.roundedBorder)
                        .foregroundColor(.black)

                    //sets boolean $isFocused to true when keyboard is pulled up
                        .focused($isFocused)
                    
                    Button(action: {
                        print("ENTERED USERNAME: \(enteredUser)")
                        // Create new network
                        let postReq = APIRequest(endpoint: "/verify")
                        var httpResponse: String = ""
                        postReq.verifyUser(enteredUser, completion: { result in
                            switch result {
                            case .success(let message):
                                print("Success")
                                httpResponse = message
                                print(httpResponse)
                            case .failure(let error):
                                print("Error", error)
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
                }.modifier(CustomViewModifier(roundedCornes: 6, startColor: .blue, endColor: .purple, textColor: .white))
            }
    }
}


struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}

struct newView: View {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        Text("Hello, \(name)")
    }
}
