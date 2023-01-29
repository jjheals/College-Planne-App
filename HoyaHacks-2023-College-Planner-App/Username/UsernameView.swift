//
//  UsernameView.swift
//  HoyaHacks-2023-College-Planner-App
//
//  Created by Anay Gandhi on 1/27/23.
//
 
import SwiftUI
import Auth0
import JWTDecode
import SimpleKeychain

struct UsernameView: View {
    
    @State private var isAuthenticated = false
    @State var userProfile = Profile.empty
    
    var body: some View {
        
      if isAuthenticated {
        
        // “Logged in” screen
        // ------------------
        // When the user is logged in, they should see:
        //
        // - The title text “You’re logged in!”
        // - Their photo
        // - Their name
        // - Their email address
        // - The "Log out” button
        
        VStack {
          
          Text("You’re logged in!")
            .modifier(TitleStyle())
    
          UserImage(urlString: userProfile.picture)
          
          VStack {
            Text("Name: \(userProfile.name)")
            Text("Email: \(userProfile.email)")
          }
          .padding()
          
          Button("Log out") {
            logout()
          }
          .buttonStyle(MyButtonStyle())
          
        } // VStack
      
      } else {
        
        // “Logged out” screen
        // ------------------
        // When the user is logged out, they should see:
        //
        // - The title text “SwiftUI Login Demo”
        // - The ”Log in” button
        
        VStack {
          
          Text("SwiftUI Login demo")
            .modifier(TitleStyle())
          
          Button("Log in") {
            login()
          }
          .buttonStyle(MyButtonStyle())
          
        } // VStack
        
      } // if isAuthenticated
      
    } // body
    
    
    // MARK: Custom views
    // ------------------
    
    struct UserImage: View {
      // Given the URL of the user’s picture, this view asynchronously
      // loads that picture and displays it. It displays a “person”
      // placeholder image while downloading the picture or if
      // the picture has failed to download.
      
      var urlString: String
      
      var body: some View {
        AsyncImage(url: URL(string: urlString)) { image in
          image
            .frame(maxWidth: 128)
        } placeholder: {
          Image(systemName: "person.circle.fill")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: 128)
            .foregroundColor(.blue)
            .opacity(0.5)
        }
        .padding(40)
      }
    }
    
    
    // MARK: View modifiers
    // --------------------
    
    struct TitleStyle: ViewModifier {
      let titleFontBold = Font.title.weight(.bold)
      let navyBlue = Color(red: 0, green: 0, blue: 0.5)
      
      func body(content: Content) -> some View {
        content
          .font(titleFontBold)
          .foregroundColor(navyBlue)
          .padding()
      }
    }
    
    struct MyButtonStyle: ButtonStyle {
      let navyBlue = Color(red: 0, green: 0, blue: 0.5)
      
      func makeBody(configuration: Configuration) -> some View {
        configuration.label
          .padding()
          .background(navyBlue)
          .foregroundColor(.white)
          .clipShape(Capsule())
      }
    }
    
  }


extension UsernameView {
    
    func login() {
      Auth0
        .webAuth()
        .start { result in
          switch result {
            case .failure(let error):
              print("Failed with: \(error)")

            case .success(let credentials):
              self.isAuthenticated = true
              self.userProfile = Profile.from(credentials.idToken)
              print("Credentials: \(credentials)")
              print("ID token: \(credentials.idToken)")
          }
        }
    }
    
    func logout() {
      Auth0
        .webAuth()
        .clearSession { result in
          switch result {
            case .success:
              self.isAuthenticated = false
              self.userProfile = Profile.empty

            case .failure(let error):
              print("Failed with: \(error)")
          }
        }
    }
}


//
//    @State private var enteredUser: String = ""
//    //var to dictate whether the keyboard is brought up or not
//    @FocusState private var isFocused: Bool
//    @State private var isButtonVisible = true
//
////    var testUsername: String = " "
//
////    init(testUsername1: String) {
////        self.testUsername = testUsername1
////        print(testUsername1 + " <-----")
////    }
////
////    init() {}
//
//    var body: some View {
//        if isButtonVisible {
//            ZStack {
//                VStack (alignment: .center, spacing: 15) {
//                    TextField("Enter a username", text: $enteredUser)
//                        .multilineTextAlignment(.center)
//                        .textFieldStyle(.roundedBorder)
//                        .foregroundColor(.black)
//
//                    //sets boolean $isFocused to true when keyboard is pulled up
//                        .focused($isFocused)
//
//
//                        Button(action: {
//                            print("ENTERED USERNAME: \(enteredUser)")
//                            // Create new network
//                            let postReq = APIRequest(endpoint: "/verify")
//                            postReq.verifyUser(enteredUser, completion: { result in
//                                switch result {
//                                case .success(let message):
//                                    print(message)
//                                    print("Success")
//                                    self.isButtonVisible = false
//                                    newView(name: enteredUser)
////                                    UsernameView(testUsername1: enteredUser)
//                                case .failure(let error):
//                                    print(result)
//                                    print("Error", error)
//                                    UsernameView()
//                                }
//                            })
//                            isFocused = false
//                        }, label: {
//                            Capsule().overlay (
//                                Text("Enter")
//                                    .foregroundColor(.black)
//                                    .padding()
//                            ).frame (width: 100, height: 40)
//                        }
//                        )
//                    }
//                }.modifier(CustomViewModifier(roundedCornes: 6, startColor: .blue, endColor: .purple, textColor: .white))
//        }


struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
//        UsernameView(testUsername1: "")
        UsernameView()
    }
}

//struct newView: View {
//
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    var body: some View {
//        VStack{
//            Text("Hello, \(self.name)")
//        }
//    }
//}


