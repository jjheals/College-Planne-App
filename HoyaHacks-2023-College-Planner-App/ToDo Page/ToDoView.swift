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
        ZStack {
            displayAssignments()
            EditButtonToDo()
        }
    }
}

//local testing date for the To-Do List
public class data {
    @Published var assignments: OrderedDictionary = [
        "Problem Set": "Sun Jan 1",

        "Titration Set": "Mon Jan 2",

        "DS Project": "Tues Jan 3",
        
        "DB Project": "Wed Jan 4",
        
        "Ideas Paper": "Thurs Jan 5",
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

struct ToDoView_UI_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView_UI()
        displayAssignments()
    }
}
