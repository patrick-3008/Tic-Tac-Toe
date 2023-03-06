//
//  Alerts.swift
//  Tic Tac Toe
//
//  Created by iMac on 19/09/2022.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You win"), message: Text("You beat the incredible AI in a seconds!"), buttonTitle: Text("Hell Yeah"))
    static let cpuWin = AlertItem(title: Text("You lost"), message: Text("The AI beats you easily\ndo you really thinks that you can win 😂 !"), buttonTitle: Text("Try again"))
    static let human1Win = AlertItem(title: Text("X Win"), message: Text("The X player beats you easily!"), buttonTitle: Text("Play again"))
    static let human2Win = AlertItem(title: Text("O Win"), message: Text("The O player beats you easily!"), buttonTitle: Text("Play again"))
    static let draw = AlertItem(title: Text("Draw"), message: Text("No winner for this game."), buttonTitle: Text("Rematch"))
}
