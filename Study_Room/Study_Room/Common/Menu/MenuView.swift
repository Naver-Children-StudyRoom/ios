//
//  MenuView.swift
//  Study_Room
//
//  Created by Joo Young Kim on 2022/03/18.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            MenuDetailView(menuTitle: "Test")
                .padding(.top, 100)
            MenuDetailView(menuTitle: "test2")
            MenuDetailView(menuTitle: "test3")
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 32/255, green: 32/255, blue: 32/255))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
