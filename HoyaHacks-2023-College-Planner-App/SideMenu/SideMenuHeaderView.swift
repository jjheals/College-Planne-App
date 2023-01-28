//
//  SideMenuHeaderView.swift
//  SideMenu
// 
//  Created by Anay Gandhi on 1/27/23
//

import SwiftUI

struct SideMenuHeaderView: View {
    @Binding var isShowing: Bool

    var body: some View {
        //x out of the sidemenu
            Button(action: {
                withAnimation(.spring()) {
                    isShowing.toggle()
                }
            }, label: {
                Image(systemName: "xmark")
                    .frame(width: 100, height: 100)
                    .foregroundColor(.white)
                }
            )
            .foregroundColor(.white)
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowing: .constant(true))
    }
}

