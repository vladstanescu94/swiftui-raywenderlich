//
//  ContentView.swift
//  Bullseye
//
//  Created by Vlad Stanescu on 12.01.2021.
//

import SwiftUI

struct ContentView: View {
    @State private var alertIsVisible: Bool = false
    
    var body: some View {
        VStack {
            Text("Welcome to my first app!")
                .fontWeight(.semibold)
                .foregroundColor(Color.green)
                .padding()
            Button(action: {
                print("Button pressed!")
                alertIsVisible.toggle()
            }) {
                Text("Hit me!")
            }
            .alert(isPresented: $alertIsVisible) { () -> Alert in
                return Alert(title: Text("Hello there!"), message: Text("This is my first pop-up"), dismissButton: .default(Text("Awesome!")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
