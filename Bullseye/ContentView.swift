//
//  ContentView.swift
//  Bullseye
//
//  Created by Vlad Stanescu on 12.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var alertIsVisible: Bool = false
    @State private var sliderValue: Double = 50.0
    @State private var target: Int = Int.random(in: 1...100)
    
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
                Slider(value: $sliderValue, in: 1...100, step: 1.0)
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
                return Alert(title: Text("Hello there!"), message: Text("The slider value is \(Int(sliderValue.rounded()))"), dismissButton: .default(Text("Awesome!")))
            }
            Spacer()
            // Score row
            HStack {
                Button(action: {}, label: {
                    Text("Start over")
                })
                Spacer()
                Text("Score:")
                Text("99999")
                Spacer()
                Text("Round:")
                Text("99999")
                Spacer()
                Button(action: {}, label: {
                    Text("Info")
                })
            }
            .padding(.bottom)
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
