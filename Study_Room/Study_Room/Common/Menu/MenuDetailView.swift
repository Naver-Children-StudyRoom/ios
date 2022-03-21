//
//  MenuDetailView.swift
//  Study_Room
//
//  Created by JooYoung Kim on 2022/03/21.
//

import SwiftUI

struct MenuDetailView: View {
    var menuTitle: String
    
    var body: some View {
        HStack {
            Text(menuTitle)
                .foregroundColor(.gray)
                .font(.headline)
        }
        .frame(maxWidth: .infinity)
    }
}

struct MenuDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MenuDetailView(menuTitle: "test")
    }
}
