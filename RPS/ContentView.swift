//
//  ContentView.swift
//  RPS
//
//  Created by Andrei Korikov on 24.03.2021.
//

import SwiftUI

struct ContentView: View {
    let figures = ["Rock", "Paper", "Scissors"]
    let totalRounds = 10
    
    @State private var isPlayerShouldWin = Bool.random()
    @State private var aiFigure = Int.random(in: 0..<3)
    @State private var playerFigure: Int? = nil
    @State private var score = 0
    @State private var currentRound = 1
    @State private var isEndOfGame = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.orange, .blue]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 10) {
                HStack {
                    Text("Score: \(score)")
                    Text("Round \(currentRound) \\ \(totalRounds)")
                }
                .font(.title3)
                .foregroundColor(.white)
                
                Spacer()
                
                HStack {
                    Text("AI make it move and select:)")
                    Text(figures[aiFigure])
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                HStack {
                    Text("You should ")
                    Text(isPlayerShouldWin ? "Win." : "Lose.")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                
                Spacer()
                
                VStack(spacing: 20){
                    ForEach(figures, id: \.self) { figure in
                        Button(action: {
                            playerMakeMove(figure)
                        }, label: {
                            Text(figure)
                                .foregroundColor(.white)
                                .font(.largeTitle)
                        })
                    }
                }
                .alert(isPresented: $isEndOfGame) {
                    Alert(title: Text("You score is \(score)"),
                          message: Text("Start a new game?"),
                          primaryButton: .default(Text("Yes"),
                                                  action: {
                                                    score = 0
                                                    currentRound = 1
                                                    makeNewRound()
                                                    }),
                          secondaryButton: .cancel(Text("No")))
                }
                
                Spacer()
            }
        }
    }
    
    func playerMakeMove(_ figure: String) {
        playerFigure = figures.firstIndex(of: figure)
        
        var prevFigure: Int = playerFigure! - 1
        prevFigure = prevFigure < 0 ? figures.count - 1 : prevFigure
        
        if (aiFigure == prevFigure && isPlayerShouldWin) ||
           (aiFigure != prevFigure && !isPlayerShouldWin) {
            score += 1
        } else {
            score -= 1
        }
        
        currentRound += 1
        
        if currentRound >= totalRounds {
            isEndOfGame = true
        } else {
            makeNewRound()
        }
    }
    
    func makeNewRound() {
        isPlayerShouldWin = Bool.random()
        aiFigure = Int.random(in: 0..<3)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
