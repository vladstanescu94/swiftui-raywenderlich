//
//  AboutView.swift
//  Bullseye
//
//  Created by Vlad Stanescu on 13.01.2021.
//

import SwiftUI

struct AboutView: View {
    let aboutBackground = Color(.sRGB, red: 1, green: 214/255.0, blue: 179/255.0, opacity: 1)
    var body: some View {
        Group {
            VStack {
                Text("🎯 Bullseye 🎯")
                    .modifier(HeadingStyle())
                Text("This is Bullseye, the game where you can win points and earn fame by dragging a slider.")
                    .modifier(AboutTextStyle())
                Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.")
                    .modifier(AboutTextStyle())
                Text("Enjoy!")
                    .modifier(AboutTextStyle())
            }
            .background(aboutBackground)
            .navigationBarTitle("About Bullseye")
        }
        .background(Image("Background"))
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
            .previewLayout(.fixed(width: 896, height: 414))
    }
}
