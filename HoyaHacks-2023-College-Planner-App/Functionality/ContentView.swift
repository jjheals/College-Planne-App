//
//  ContentView.swift
//  SideMenu
//
//  Created by Anay Gandhi on 1/27/23.
// 

import SwiftUI

struct ContentView: View {
    @State private var isShowing = false;

    var body: some View {
        NavigationView {
            ZStack {
                if isShowing {
                    SideMenuView(isShowing: $isShowing)
                }
    
                HomeView()
                
                //all these attributes are for the animation
                    .cornerRadius(isShowing ? 20 : 10)
                    .offset(x: isShowing ? 300 : 0, y: isShowing ? 44 : 0)
                    .scaleEffect(isShowing ? 0.8 : 1)
                    .navigationBarItems(leading: Button(action:{
                        withAnimation(.spring()) {
                            isShowing.toggle()
                        }
                    }, label:{Image(systemName: "list.bullet").foregroundColor(.black)
                    }))
                    .navigationTitle("Dashboard")
                    .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}

struct HomeView: View {
    var body: some View {
        ZStack {
            Color(.white)
            if (username().user.count == 0) {
                UsernameView()
            } else {
                Text("Hello, " + username().user + "!")
            }
        }
    }
}


////testing structs for username
//struct testUserView: View {
//    var body: some View {
//        if (username().user.count == 0) {
//                UsernameView()
//        }
//    }
//}
//
//
//struct HomeView: View {
//    var body: some View {
//        ZStack {
//            Color(.white)
//            if (username().user.count != 0) {
//                Text("Hello World")
//            }
//        }
//    }
//}
