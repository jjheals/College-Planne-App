//
//  SideMenuView.swift
//  SideMenu
//
//  Created by Anay Gandhi on 1/27/23
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        //vstack has all elements including x button and cells
            VStack{
                //hstack has just the x button and spacer pushes it all the way to the right
                HStack {
                    Spacer()
                    SideMenuHeaderView(isShowing: $isShowing)
                        .alignmentGuide(.trailing) {
                            v in v[HorizontalAlignment.trailing]
                        }
                }
                
                ForEach(SideMenuViewModel.allCases, id: \.self) { option in
                    if(option == .dashboard) {
                        NavigationLink(destination: DashboardViewTest(), label: { SideMenuOptionView(viewModel: option) } )
                    }
                    else if(option == .calendar) {
                        NavigationLink(destination: CalendarView_UI(), label: { SideMenuOptionView(viewModel: option) } )
                    }
                    else { NavigationLink (destination: ToDoView_UI(), label: { SideMenuOptionView(viewModel: option) } )
                    }
                }
                    Spacer()
            }
        }   .navigationBarHidden(true)
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true))
    }
}
