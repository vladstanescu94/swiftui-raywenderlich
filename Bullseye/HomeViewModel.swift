//
//  HomeViewModel.swift
//  Bullseye
//
//  Created by Vlad Stanescu on 13.01.2021.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var sliderValue: Double
    @Published var target: Int
    @Published var score: Int
    @Published var roundCounter: Int
    
    init(sliderValue: Double = 50.0, target: Int = Int.random(in: 1...100), score: Int = 0, roundCounter: Int = 1) {
        self.sliderValue = sliderValue
        self.target = target
        self.score = score
        self.roundCounter = roundCounter
    }
    
    func roundSliderValue() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func calculateDifferenceFromTarget() -> Int {
        return abs(roundSliderValue() - target)
    }
    
    func calculateBonusPoints() -> Int {
        let bonus: Int
        let difference = calculateDifferenceFromTarget()
        
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        return bonus
    }
    
    func calculatePointsForCurrentRound() -> Int {
        let maxScore = 100
        return maxScore - calculateDifferenceFromTarget() + calculateBonusPoints()
    }
    
    
    func generateAlertTitle() -> String {
        let title: String
        let difference = calculateDifferenceFromTarget()
        
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else {
            title = "Are you even trying?"
        }
        
        return title
    }
    
    func updateGameState() {
        score += calculatePointsForCurrentRound()
        target = Int.random(in: 1...100)
        roundCounter += 1
    }
    
    func reset() {
        score = 0
        roundCounter = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
}
