//
//  SideMenuViewModel.swift
//  College-Planner-App-SwiftUI
//
//  Created by Anay Gandhi on 1/27/23
//

import Foundation
import SwiftUI

//needs to be changed to data model
enum SideMenuViewModel: Int, CaseIterable {
    case dashboard
    case calendar
    case toDoList
    
    var title: String {
        switch self {
        case .dashboard: return "Dashboard"
        case .calendar: return "Calendar"
        case .toDoList: return "To-Do List"
        }
    }
    
    var imageName: String {
        switch self {
        case .dashboard: return "house"
        case .calendar: return "calendar.circle"
        case .toDoList: return "list.clipboard"
        }
    }
    
    
}

