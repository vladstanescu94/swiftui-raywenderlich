//
//  ContentView.swift
//  Bullseye
//
//  Created by Vlad Stanescu on 12.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var alertIsVisible: Bool = false
    @State private var sliderValue: Double = 0.0
    
    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("100")
            }
            Spacer()
            // Slider row
            HStack {
                Text("1")
                Slider(value: $sliderValue)
                Text("100")
            }
            Spacer()
            // Button row
            Button(action: {
                print("Button pressed!")
                alertIsVisible.toggle()
            }) {
                Text("Hit me!")
            }
            .padding()
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text("Hello there!"), message: Text("This is my first pop-up"), dismissButton: .default(Text("Awesome!")))
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
