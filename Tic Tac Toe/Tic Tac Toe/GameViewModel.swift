//
//  GameViewModel.swift
//  Tic Tac Toe
//
//  Created by iMac on 19/09/2022.
//
//  View-Model

import SwiftUI

final class gameViewModel: ObservableObject {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                              GridItem(.flexible()),
                              GridItem(.flexible())]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled = false
    @Published var alertItem: AlertItem?
    
    private(set) var playerTurn = true
    func process2PlayerMove(for position: Int) {
        
        // 1 st Player Turn
        if playerTurn {
            if !isSquareAvailable(in: moves, forIndex: position) { return }
            moves[position] = Move(player: .player1, boardIndex: position)
            
            if checkWinCondition(for: .player1, in: moves) {
                alertItem = AlertContext.human1Win
                return
            }
            
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }
            playerTurn.toggle()
            
        } else {
            
            // 2 nd Player Turn
            if !isSquareAvailable(in: moves, forIndex: position) { return }
            moves[position] = Move(player: .player2, boardIndex: position)
            
            if checkWinCondition(for: .player2, in: moves) {
                alertItem = AlertContext.human2Win
                return
            }
            
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }
            playerTurn.toggle()
        }
    }
    
    func processPlayerMove(for position: Int) {
        
        // human move processing
        if !isSquareAvailable(in: moves, forIndex: position) { return }
        moves[position] = Move(player: .player1, boardIndex: position)
        
        if checkWinCondition(for: .player1, in: moves) {
            alertItem = AlertContext.humanWin
            return
        }
        
        if checkForDraw(in: moves) {
            alertItem = AlertContext.draw
            return
        }
        
        isGameBoardDisabled = true

        // computer move processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
            let computerPostion = determineCpuMovePostion(in: moves)
            moves[computerPostion] = Move(player: .computer, boardIndex: computerPostion)
            isGameBoardDisabled = false
            
            if checkWinCondition(for: .computer, in: moves) {
                alertItem = AlertContext.cpuWin
                return
            }
            
            if checkForDraw(in: moves) {
                alertItem = AlertContext.draw
                return
            }
        }
    }
    
    func isSquareAvailable(in moves: [Move?], forIndex index: Int) -> Bool {
        return !moves.contains(where: { $0?.boardIndex == index })
    }
    
    // Steps
    // if ai can win, then win
    // if ai cant win, then block
    // if ai cant block, then take middle square
    // if ai cant take midle square, take random available square
    func determineCpuMovePostion(in move: [Move?]) -> Int {
        
        // if ai can win, then win
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        let cpuMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let cpuPostions = Set(cpuMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPostions = pattern.subtracting(cpuPostions)
            
            if winPostions.count == 1 {
                let isAvaiable = isSquareAvailable(in: moves, forIndex: winPostions.first!)
                if isAvaiable { return winPostions.first!}
            }
        }
        
        // if ai cant win, then block
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .player1 }
        let humanPostions = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPatterns {
            let winPostions = pattern.subtracting(humanPostions)
            
            if winPostions.count == 1 {
                let isAvaiable = isSquareAvailable(in: moves, forIndex: winPostions.first!)
                if isAvaiable { return winPostions.first!}
            }
        }
        
        // if ai cant block, then take middle square
        let centreSquare = 4
        if isSquareAvailable(in: moves, forIndex: centreSquare) { return centreSquare }

        // if ai cant take midle square, take random available square
        var movePostion = Int.random(in: 0..<9)
        
        while !isSquareAvailable(in: moves, forIndex: movePostion) {
            movePostion = Int.random(in: 0..<9)
        }
        
        return movePostion
    }
    
    func checkWinCondition(for player: Player, in Moves: [Move?]) -> Bool {
        let winPatterns: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPostions = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPatterns where pattern.isSubset(of: playerPostions) { return true }
        
        return false
    }
    
    func checkForDraw(in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
    
    func viewPlayerTurn() -> Bool {
        playerTurn
    }

}
