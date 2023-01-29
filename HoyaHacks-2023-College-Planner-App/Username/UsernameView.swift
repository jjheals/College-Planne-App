//
//  UsernameView.swift
//  HoyaHacks-2023-College-Planner-App
//
//  Created by Anay Gandhi on 1/27/23.
//
 
import SwiftUI
import Auth0
import JWTDecode
import iPhoneNumberField

struct UsernameView: View {
    
    @State private var isAuthenticated = false
    @State var userProfile = Profile.empty
    @State var number: String = ""
    @State var isEditing: Bool = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
      if isAuthenticated {
          ScrollView {
              VStack {
                  
                  Text("You’re logged in!")
                      .modifier(TitleStyle())
                  
                  UserImage(urlString: userProfile.picture)
                  
                  VStack {
                      Text("Name: \(userProfile.name)")
                      Text("Email: \(userProfile.email)")
                      iPhoneNumberField("(000) 000-0000", text: $number, isEditing: $isEditing)
                          .flagHidden(false)
                          .flagSelectable(true)
                          .font(UIFont(size: 30, weight: .light, design: .monospaced))
                          .maximumDigits(10)
                          .foregroundColor(Color.pink)
                          .clearButtonMode(.whileEditing)
                          .onClear { _ in isEditing.toggle() }
                          .accentColor(Color.orange)
                          .padding()
                          .background(Color.white)
                          .cornerRadius(10)
                          .shadow(color: isEditing ? .gray : .white, radius: 10)
                          .padding()
                          .focused($isFocused)
                  }
                  .padding()
                  
                  
                  Button("Submit") {
                      var editedEmail = removeEverythingAfterAt(email: userProfile.email)
                      let postReq = APIRequest(endpoint: "/add-phone")
                      postReq.verifyPhone(number, id: editedEmail, completion: { result in
                          switch result {
                          case .success(let message):
                              print(message)
                              print("Success")
                              isFocused = false
                              
                         case .failure(let error):
                              print(result)
                              print("Error", error)
                              isFocused = false

                          }
                      })
                  }
                  .buttonStyle(MyButtonStyle())
                  
                  Button("Log out") {
                      logout()
                  }
                  .buttonStyle(MyButtonStyle())
                  
              } // VStack
          }
      } else {
        
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
    
    func removeEverythingAfterAt(email: String) -> String {
        let components = email.split(separator: "@")
        return String(components[0])
    }
    
    struct UserImage: View {

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

struct UsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameView()
    }
}


