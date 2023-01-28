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
                    Button(action: {
//                        var jsonBody = JSONSerialization.data(withJSONObject: ["username":$enteredUser], options:[])
//                        let req = HTTPReq(username: enteredUser, body: jsonBody)
//
//                        if (req.sendReq("/create-user")) {
//                            HomeView()
//                        } else {
//                            // Error
//                            }
                        
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
