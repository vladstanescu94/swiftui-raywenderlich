//
//  ContentView.swift
//  Bullseye
//
//  Created by Vlad Stanescu on 12.01.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var homeViewModel = HomeViewModel()
    @State private var alertIsVisible = false
    
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
    
    struct PaddingHuge: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .padding(.vertical, 28)
                .padding(.horizontal, 48)
            
        }
    }
    
    struct CustomButton: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .frame(minWidth: 200, minHeight: 80)
                .background(Image("Button").resizable().aspectRatio(contentMode: .fit))
        }
    }
    
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
                Button(action: {}, label: {
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
