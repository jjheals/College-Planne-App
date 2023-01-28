//
//  DashboardView-UI.swift
//  College-Planner-App-SwiftUI
//
//  Created by Anay Gandhi on 1/27/23
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
        EditButtonDashboard()
    }
}

struct DashboardView_UI_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView_UI()
    }
}
