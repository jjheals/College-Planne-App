//
//  ToDoView-UI.swift
//  College-Planner-App-SwiftUI
//
//  Created by Anay Gandhi on 1/27/23
//

import SwiftUI

struct ToDoView_UI: View {
    var body: some View {
        VStack {
            Text("To-Do List")
                .font(.headline).bold()
            Spacer()
        }
        EditButtonToDo()
        
    }
}

////local testing date for the To-Do List
//public class data {
//    @Published var assignments: Dictionary = [
//        "Problem Set":  [
//            "Due Date": "Sun Jan 1, 2023",
//        ],
//
//        "Titration Set": [
//            "Due Date": "Mon Jan 2, 2023",
//        ],
//        
//        "DS Project": [
//            "Due Date": "Tues Jan 3, 2023",
//        ]
//    ]
//}

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

struct ToDoView_UI_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView_UI()
    }
}
