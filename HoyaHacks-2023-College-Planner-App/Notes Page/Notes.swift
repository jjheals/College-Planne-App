//
//  ToDoView-UI.swift
//  College-Planner-App-SwiftUI
//
//  Created by Anay Gandhi on 1/27/23
//
 
import SwiftUI

struct Notes: View {
    
    struct FileItem: Hashable, Identifiable, CustomStringConvertible {
        var id: Self { self }
        var name: String
        var children: [FileItem]? = nil
        var description: String {
            switch children {
            case nil:
                return "📄 \(name)"
            case .some(let children):
                return children.isEmpty ? "📂 \(name)" : "📁 \(name)"
            }
        }
    }
    
    let fileHierarchyData: [FileItem] = [
         FileItem(name: "Semester 1", children:
           [FileItem(name: "Subjects", children:
             [FileItem(name: "Math", children:
               [FileItem(name: "calculus.jpg"),
                FileItem(name: "statistics.jpg")]),
              FileItem(name: "Science", children:
                [FileItem(name: "chemistry.mp4")]),
                 FileItem(name: "History", children: [])
             ]),
            FileItem(name: "Misc", children:
              [FileItem(name: "Documents", children: [])
              ])
           ]),
           FileItem(name: "private", children: nil)
       ]
    
       var body: some View {
           List(fileHierarchyData, children: \.children) { item in
               Text(item.description)
           }
       }
}

////local testing date for the To-Do List
//public class data {
//    @Published var assignments: OrderedDictionary = [
//        "Problem Set": "Sun Jan 1",
//
//        "Titration Set": "Mon Jan 2",
//
//        "DS Project": "Tues Jan 3",
//
//        "DB Project": "Wed Jan 4",
//
//        "Ideas Paper": "Thurs Jan 5",
//    ]
//}
//
//struct displayAssignments: View {
//
//    var body: some View {
//        let keys = data().assignments.map {$0.key}
//        let values = data().assignments.map {$0.value}
//
//        return List {
//            ForEach(keys.indices) {index in
//                HStack (alignment: .center, spacing: 5){
//                    Text(keys[index])
//                        .multilineTextAlignment(.leading)
//                    Spacer()
////        //uncomment to create a re-usable checkbox for each of the assignments with there dueDates
////                    CheckBoxViewHolder()
////                    Spacer()
//                    Text("\(values[index])")
//                        .multilineTextAlignment(.leading)
//                }
//            }
//        }
//    }
//}

struct ToDoView_UI_Previews: PreviewProvider {
    static var previews: some View {
        Notes()
    }
}
