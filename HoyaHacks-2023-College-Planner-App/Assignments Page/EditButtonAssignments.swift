//
//  EditButtonDashboard.swift
//  HoyaHacks-2023-College-Planner-App
// 
//  Created by Anay Gandhi on 1/27/23.
//

import SwiftUI

struct EditButtonAssignments: View {
    @State private var ShowTextField = false
    @State private var enteredSubject: String = ""
    @State private var enteredAssignment: String = ""
    @State private var enteredDueDate: String = ""
    
    var body: some View {
        if ShowTextField {
            ZStack {
//                RoundedRectangle(cornerRadius: 20)
//                    .foregroundColor(.blue)
//                    .frame(width: 200, height: 100)
//                RoundedRectangle(cornerRadius: 20)
//                    .foregroundColor(.white)
//                    .frame(width: 180, height: 80)
                VStack (alignment: .center, spacing: 15) {
                    TextField("Enter Subject", text: $enteredSubject)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                        .accentColor(.black)
                    TextField("Enter Assignment", text: $enteredAssignment)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                    TextField("Enter Due Date", text: $enteredDueDate)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(.roundedBorder)
                    Button(action: {
                        
            // space for json request
                        
                        }, label: {
                            Text("Enter")
                        }
                    )

                }.modifier(CustomViewModifier(roundedCornes: 6, startColor: .blue, endColor: .purple, textColor: .black))
            }
        }
        
        VStack {
            
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Button(action: {
                        self.ShowTextField.toggle()
                    }) {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size:48))
                            .padding()
                    }
                }
            }
        }
    }
}

struct EditButtonAssignments_Previews: PreviewProvider {
    static var previews: some View {
        EditButtonAssignments()
    }
}
