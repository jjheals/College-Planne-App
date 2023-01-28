//
//  SideMenuOptionView.swift
//  SideMenu
// 
//  Created by Anay Gandhi on 1/27/23
//

import SwiftUI

struct SideMenuOptionView: View {

    let viewModel: SideMenuViewModel
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: viewModel.imageName) //calls images from model
                .frame(width: 24, height: 24)
            
            Text(viewModel.title) //calls test from model
                .font(.system(size: 15, weight: .semibold))
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
    }
}

struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionView(viewModel: .assignments)
    }
}
