//
//  GameModel.swift
//  Tic Tac Toe
//
//  Created by iMac on 19/09/2022.
//
//  Model

import Foundation

enum Player {
    case player1, player2, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        if player == .player1 {
            return "xmark"
        } else if player == .player2 {
            return "circle"
        } else {
            return "circle"
        }
    }
}
