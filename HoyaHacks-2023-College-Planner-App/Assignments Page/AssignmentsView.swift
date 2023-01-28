//
//  DashboardView-UI.swift
//  College-Planner-App-SwiftUI
// 
//  Created by Anay Gandhi on 1/27/23
//

import SwiftUI

struct AssignmentsView: View {
    
    struct Assignment: Hashable, Identifiable {
        let name: String
        let dueDate: String
        let id = UUID()
    }
    
    struct Subject: Identifiable {
        let name: String
        let assignments: [Assignment]
        let id = UUID()
    }
    
    private let subjects: [Subject] = [
            Subject(name: "Math",
                    assignments: [Assignment(name: "Calc Problem Set", dueDate: "Sun Jan 1"),
                                  Assignment(name: "Stat Paper", dueDate: "Mon Jan 2"),
                                      Assignment(name: "Calc Exam", dueDate: "Thurs Jan 5"),
                                      Assignment(name: "Linear Alg Problems", dueDate: "Fri Jan 6")]),
            Subject(name: "Computer Science",
                    assignments: [Assignment(name: "Java Function", dueDate: "Mon Jan 2"),
                                  Assignment(name: "SQL Practice", dueDate: "Tues Jan 3"),
                                  Assignment(name: "Python Game", dueDate: "Fri Jan 6"),
                                  Assignment(name: "R Practice", dueDate: "Sun Jan 8"),
                                  Assignment(name: "Swift App", dueDate: "Tues Jan 10")]),
            Subject(name: "History",
                    assignments: [Assignment(name: "Interview", dueDate: "Fri Jan 6")]),
            Subject(name: "Science",
                    assignments: [Assignment(name: "Titration Lab", dueDate: "Tues Jan 10")]),
            Subject(name: "English",
                    assignments: [Assignment(name: "Shakespeare Paper", dueDate: "Thurs Jan 12")]),
                    
        ]
    
    @State private var singleSelection: UUID?
    
    var body: some View {
        NavigationView {
            ZStack {
                List(selection: $singleSelection) {
                    ForEach(subjects) { subject in
                        Section(header: Text("\(subject.name) Assignments")) {
                            ForEach(subject.assignments) { assignment in
                                HStack(alignment: .center) {
                                    Text(assignment.name)
                                    Spacer()
                                    Text(assignment.dueDate)
                                }
                            }
                        }
                    }
                }
                EditButtonAssignments()
            }
        }
    }
}


struct DashboardView_UI_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentsView()
    }
}
