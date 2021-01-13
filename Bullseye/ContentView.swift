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
    
    struct CustomShadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: .black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(.white)
                .modifier(CustomShadow())
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(.custom("Arial Rounded MT Bold", size: 24))
                .foregroundColor(.yellow)
                .modifier(CustomShadow())
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                Text("\(target)")
                    .modifier(ValueStyle())
            }
            
            Spacer()
            // Slider row
            HStack {
                Text("1")
                    .modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100)
                Text("100")
                    .modifier(LabelStyle())
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
                Button(action: reset, label: {
                    Text("Start over")
                })
                .modifier(LabelStyle())
                Spacer()
                Text("Score:")
                    .modifier(LabelStyle())
                Text("\(score)")
                    .modifier(ValueStyle())
                Spacer()
                Text("Round:")
                    .modifier(LabelStyle())
                Text("\(roundCounter)")
                    .modifier(ValueStyle())
                Spacer()
                Button(action: {}, label: {
                    Text("Info")
                })
                .modifier(LabelStyle())
            }
            .padding(.bottom)
            
        }
        .background(Image("Background"), alignment: .center)
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
    
    func reset() {
        score = 0
        roundCounter = 1
        sliderValue = 50.0
        target = Int.random(in: 1...100)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
