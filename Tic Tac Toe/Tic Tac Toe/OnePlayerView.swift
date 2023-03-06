//
//  OnePlayerView.swift
//  Tic Tac Toe
//
//  Created by iMac on 19/09/2022.
//
// View

import SwiftUI

struct OnePlayerView: View {
    
    @StateObject private var viewModel = gameViewModel()
    
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
                            viewModel.processPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
                Text("Try to Win 😜")
                    .font(.title2)
            }
            .disabled(viewModel.isGameBoardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: { viewModel.resetGame() }))
            })
        }
    }
    
}

struct GameSquareView: View {
    
    var proxy: GeometryProxy
    
    var body: some View {
        Rectangle()
            .foregroundColor(.blue)
            .opacity(0.5)
            .frame(width: proxy.size.width/3 - 15, height: proxy.size.width/3 - 20)
            .cornerRadius(8)
    }
}

struct PlayerIndicator: View {
    
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 60, height: 60)
            .foregroundColor(.black)
    }
}

// MARK: - Simulator(s)

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnePlayerView()
    }
}


