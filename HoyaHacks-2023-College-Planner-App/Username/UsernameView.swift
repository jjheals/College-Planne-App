//
//  UsernameView.swift
//  HoyaHacks-2023-College-Planner-App
//
//  Created by Anay Gandhi on 1/27/23.
//

import SwiftUI

class username: ObservableObject {
    @Published var user: String = ""
}

struct UsernameView: View {
    @State private var enteredUser: String = ""
    @State var hasUser: Bool = (username().user.count != 0)
    
    var body: some View {

        if hasUser {
            HomeView()
        } else {
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
                }
            }
        }
    }
}

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}
