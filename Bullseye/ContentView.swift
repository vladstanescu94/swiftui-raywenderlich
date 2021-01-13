//
//  ContentView.swift
//  Bullseye
//
//  Created by Vlad Stanescu on 12.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var alertIsVisible = false
    @State private var sliderValue = 50.0
    @State private var target = Int.random(in: 1...100)
    @State private var score = 0
    @State private var roundCounter = 1
    
    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(target)")
            }
            Spacer()
            // Slider row
            HStack {
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            // Button row
            Button(action: {
                alertIsVisible.toggle()
            }) {
                Text("Hit me!")
            }
            .padding()
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text(generateAlertTitle()), message: Text("The slider value is \(roundSliderValue()). \n" +
                    "You scored \(calculatePointsForCurrentRound()) points this round."
                ), dismissButton: .default(Text("Awesome!")) {
                    score += calculatePointsForCurrentRound()
                    target = Int.random(in: 1...100)
                    roundCounter += 1
                })
            }
            Spacer()
            // Score row
            HStack {
                Button(action: {}, label: {
                    Text("Start over")
                })
                Spacer()
                Text("Score:")
                Text("\(score)")
                Spacer()
                Text("Round:")
                Text("\(roundCounter)")
                Spacer()
                Button(action: {}, label: {
                    Text("Info")
                })
            }
            .padding(.bottom)
            
        }
        .padding()
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
