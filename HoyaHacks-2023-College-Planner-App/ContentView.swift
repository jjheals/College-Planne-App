//
//  ContentView.swift
//  SideMenu
//
//  Created by Anay Gandhi on 1/24/23.
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
            
            Text("Hello, World!")
                .padding()
        }
        
    }
}
