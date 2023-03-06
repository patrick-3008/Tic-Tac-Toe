//
//  TwoPlayerView.swift
//  Tic Tac Toe
//
//  Created by iMac on 21/09/2022.
//
// View

import SwiftUI

struct TwoPlayerView: View {
    
    @StateObject private var viewModel = gameViewModel()
    @State private var arrow = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Tic Tac Toe")
                    .font(.title)
                Spacer()
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            GameSquareView(proxy: geometry)
                            PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.process2PlayerMove(for: i)
                            withAnimation(.easeInOut(duration: 1).repeatCount(4)) {
                                arrow.toggle()
                            }
                        }
                    }
                }
                
                Spacer()
               
                Image(systemName: "arrow.down")
                    .resizable()
                    .frame(width: 35, height: 45)
                    .padding(.bottom, 50.0)
                    .opacity(arrow ? 1 : 0.7)
                    .scaleEffect(arrow ? 1.5 : 1)
                    .task {
                        withAnimation(.easeInOut(duration: 1).repeatCount(6)) {
                            arrow.toggle()
                        }
                    }
                
                Text("The  \(viewModel.playerTurn ? "X" : "O") Player Turn")
                    .font(.headline)
            }
            .disabled(viewModel.isGameBoardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title, message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: { viewModel.resetGame() }))
            })
        }
    }
}

struct TwoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        TwoPlayerView()
    }
}
