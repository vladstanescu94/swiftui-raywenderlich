//
//  CustomStyles.swift
//  Bullseye
//
//  Created by Vlad Stanescu on 13.01.2021.
//

import SwiftUI

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
