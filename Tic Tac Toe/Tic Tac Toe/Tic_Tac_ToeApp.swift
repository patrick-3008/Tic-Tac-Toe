//
//  Tic_Tac_ToeApp.swift
//  Tic Tac Toe
//
//  Created by iMac on 19/09/2022.
//

import SwiftUI

@main
struct Tic_Tac_ToeApp: App {
    
    init() {
        UINavigationBar.appearance().backgroundColor =  UIColor.systemGray6
    }
    
    var body: some Scene {
        WindowGroup {
            MenuView()
        }
    }
}
