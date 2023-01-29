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




struct ToDoView_UI_Previews: PreviewProvider {
    static var previews: some View {
        Notes()
    }
}
