//
//  EditButtonView.swift
//  HoyaHacks-2023-College-Planner-App
//
//  Created by Anay Gandhi on 1/27/23.
//

import SwiftUI

struct EditButtonToDo: View {
    @State private var ShowTextField = false
    @State private var enteredAssignment: String = ""
    @State private var enteredDueDate: String = ""

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
                    TextField("Enter Assignment", text: $enteredAssignment)
                        .multilineTextAlignment(.center)
                    TextField("Enter Due Date", text: $enteredDueDate)
                        .multilineTextAlignment(.center)
                }
            }
        }
        
        VStack {
            Spacer()
                    
            HStack {
                Spacer()
                Button(action: {
                    self.ShowTextField.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.system(size:48))
                        .padding()
                    }
            }
        }
    }
}

struct EditButtonView_Previews: PreviewProvider {
    static var previews: some View {
        EditButtonToDo()
    }
}
