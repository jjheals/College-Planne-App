//
//  CheckboxView.swift
//  HoyaHacks-2023-College-Planner-App
// 
//  Created by Anay Gandhi on 1/27/23.
//

/* This file creates a checkbox and stores it as boolean "checked." The issue is that there is only one boolean variable to store all of the checkboxes value, so when one of the checkboxes are checked, then it changes the value to "true" for all checkboxes. A different variable would have to be created in the assignment: dueDate dictionary to store each of the checked statuses.*/

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    
    var body: some View {
        Image(systemName: checked ? "checkmark.square.fill" : "square")
            .foregroundColor(checked ? Color(UIColor.systemBlue) : Color.secondary)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}

struct CheckBoxViewHolder : View {
    @State var checked = true
    var body: some View {
        CheckBoxView(checked: $checked)
    }
}

struct CheckboxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxViewHolder()
    }
}
