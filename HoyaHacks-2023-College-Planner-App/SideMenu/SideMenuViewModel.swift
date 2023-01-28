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
    case assignments
    case calendar
    case notes
    
    var title: String {
        switch self {
        case .assignments: return "Assignments"
        case .calendar: return "Calendar"
        case .notes: return "Notes"
        }
    }
    
    var imageName: String {
        switch self {
        case .assignments: return "book"
        case .calendar: return "calendar.circle"
        case .notes: return "list.clipboard"
        }
    }
    
    
}

