//
//  ContentView.swift
//  Bullseye
//
//  Created by Vlad Stanescu on 12.01.2021.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @State private var alertIsVisible = false
        
    var body: some View {
        VStack {
            Spacer()
            // Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                    .modifier(LabelStyle())
                Text("\(homeViewModel.target)")
                    .modifier(ValueStyle())
            }
            
            Spacer()
            // Slider row
            HStack {
                Text("1")
                    .modifier(LabelStyle())
                Slider(value: $homeViewModel.sliderValue, in: 1...100)
                    .accentColor(.green)
                Text("100")
                    .modifier(LabelStyle())
            }
            Spacer()
            // Button row
            Button(action: {
                alertIsVisible.toggle()
            }) {
                Text("Hit me!")
                    .modifier(LabelStyle())
                    .modifier(PaddingHuge())
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text(homeViewModel.generateAlertTitle()), message: Text("The slider value is \(homeViewModel.roundSliderValue()). \n" +
                                                                                                "You scored \(homeViewModel.calculatePointsForCurrentRound()) points this round."
                ), dismissButton: .default(Text("Awesome!")) {
                    homeViewModel.updateGameState()
                })
            }
            .modifier(CustomButton())
            Spacer()
            // Score row
            HStack {
                Button(action: homeViewModel.reset, label: {
                    HStack {
                        Image("StartOverIcon")
                        Text("Start over")
                            .modifier(LabelStyle())
                    }
                })
                .modifier(CustomButton())
                
                Spacer()
                Text("Score:")
                    .modifier(LabelStyle())
                Text("\(homeViewModel.score)")
                    .modifier(ValueStyle())
                Spacer()
                Text("Round:")
                    .modifier(LabelStyle())
                Text("\(homeViewModel.roundCounter)")
                    .modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: AboutView(), label: {
                    HStack {
                        Image("InfoIcon")
                        Text("Info")
                            .modifier(LabelStyle())
                    }
                })
                .modifier(CustomButton())
            }
            .padding(.bottom)
            
        }
        .background(Image("Background"), alignment: .center)
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
