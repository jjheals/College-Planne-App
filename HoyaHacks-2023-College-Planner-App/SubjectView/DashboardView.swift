//
//  DashboardView-UI.swift
//  College-Planner-App-SwiftUI
//
//  Created by Anay Gandhi on 1/27/23.
//

import SwiftUI

var subjects = ["Math", "History", "Science", "Biology", "Chemistry", "Physics", "Calculus"]

struct DashboardView_UI: View {
    
    var body: some View {
        ScrollView {
            ForEach (subjects, id: \.self) {subject in
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.blue)
                        .frame(width: 350, height: 150)
                    Text(subject)
                }
            }
        }
        EditButtonDashboardView()
    }
}

struct EditButtonDashboardView: View {
    @State private var ShowTextField = false
    @State private var enteredSubject: String = ""
    
    var body: some View {
        if ShowTextField {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.blue)
                    .frame(width: 200, height: 100)
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .frame(width: 180, height: 80)
                VStack (alignment: .center, spacing: 15) {
                    TextField("Enter Subject", text: $enteredSubject)
                        .multilineTextAlignment(.center)
                }
            }
        }
        
        VStack {
            
            HStack {
                Spacer()
                Button(action: {
                    self.ShowTextField.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size:48))
                        .frame(maxWidth: .infinity, minHeight: 0, alignment: .trailing)
                        .padding()
                }
            }
        }
    }
}

struct DashboardView_UI_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView_UI()
    }
}
