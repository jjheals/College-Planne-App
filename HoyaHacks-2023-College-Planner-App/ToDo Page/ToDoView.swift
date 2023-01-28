//
//  ToDoView-UI.swift
//  College-Planner-App-SwiftUI
//
//  Created by Anay Gandhi on 1/27/23
//

import OrderedCollections
import SwiftUI

struct ToDoView_UI: View {
    var body: some View {
        VStack {
            Text("To-Do List")
                .font(.headline).bold()
            Spacer()
        }
        displayAssignments()
        EditButtonToDo()
    }
}

//local testing date for the To-Do List
public class data {
    @Published var assignments: OrderedDictionary = [
        "Problem Set This is a long problem set": "Sun Jan 1",

        "Titration Set": "Mon Jan 2",

        "DS Project": "Tues Jan 3"
    ]
}

struct displayAssignments: View {

    var body: some View {
        let keys = data().assignments.map {$0.key}
        let values = data().assignments.map {$0.value}

        return List {
            ForEach(keys.indices) {index in
                HStack (alignment: .center, spacing: 5){
                    Text(keys[index])
                        .multilineTextAlignment(.leading)
                    Spacer()
//        //uncomment to create a re-usable checkbox for each of the assignments with there dueDates
//                    CheckBoxViewHolder()
//                    Spacer()
                    Text("\(values[index])")
                        .multilineTextAlignment(.leading)
                }
            }
        }
    }
}

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
        displayAssignments()
    }
}
