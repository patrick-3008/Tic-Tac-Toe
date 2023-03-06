//
//  MenuView.swift
//  Tic Tac Toe
//
//  Created by iMac on 21/09/2022.
//
// View

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: OnePlayerView()) {
                    Text("1 Player")
                        .font(.headline)
                        .frame(minWidth: 300, minHeight: 70)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                }
                NavigationLink(destination: TwoPlayerView()) {
                    Text("2 Players")
                        .font(.headline)
                        .frame(minWidth: 300, minHeight: 70)
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(10)
                }
            }
            .navigationTitle("Patrick   X - O")
        }
    }
}


struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
