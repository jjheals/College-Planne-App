//
//  DashboardView-UI.swift
//  College-Planner-App-SwiftUI
//
//  Created by Anay Gandhi on 1/27/23
//

import SwiftUI

//var subjects = ["Math", "History", "Science", "Biology", "Chemistry", "Physics", "Calculus"]
struct DashboardViewTest: View {
    struct Assignment: Hashable, Identifiable {
        let name: String
        let id = UUID()
    }
    
    struct Subject: Identifiable {
        let name: String
        let assignments: [Assignment]
        let id = UUID()
    }
    
    private let subjects: [Subject] = [
            Subject(name: "Math",
                        assignments: [Assignment(name: "Calc Problem Set"),
                                      Assignment(name: "Stat Paper"),
                                      Assignment(name: "Linear Alg Problems"),
                                      Assignment(name: "Extra Practice")]),
            Subject(name: "Computer Science",
                    assignments: [Assignment(name: "Java Function"),
                                  Assignment(name: "SQL Practice"),
                                  Assignment(name: "Python Game"),
                                  Assignment(name: "R Practice"),
                                  Assignment(name: "Swift App")]),
            Subject(name: "History",
                    assignments: [Assignment(name: "Interview")]),
            Subject(name: "Science",
                    assignments: [Assignment(name: "Titration Lab")]),
            Subject(name: "English",
                    assignments: [Assignment(name: "Shakespeare Paper")]),
                    
        ]
    
    @State private var singleSelection: UUID?
    
    var body: some View {
        NavigationView {
            ZStack {
                List(selection: $singleSelection) {
                    ForEach(subjects) { subject in
                        Section(header: Text("\(subject.name) Assignments")) {
                            ForEach(subject.assignments) { assignment in
                                Text(assignment.name)
                            }
                        }
                    }
                }
                EditButtonDashboard()
            }
        }
    }
}



//struct DashboardView_UI: View {
//
//    var body: some View {
//        ScrollView {
//            ForEach (subjects, id: \.self) {subject in
//                ZStack {
//                    RoundedRectangle(cornerRadius: 20)
//                        .foregroundColor(.blue)
//                        .frame(width: 350, height: 150)
//                    Text(subject)
//                }
//            }
//        }
//        EditButtonDashboard()
//    }
//}

struct DashboardView_UI_Previews: PreviewProvider {
    static var previews: some View {
        DashboardViewTest()
    }
}
