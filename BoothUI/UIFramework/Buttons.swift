//
//  Buttons.swift
//  UIFramework
//
//  Created by Evan Welsh on 4/19/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI

public struct BoothPrimaryButtonStyle: ButtonStyle {
    
    public init() {}
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color(red: 47/255.0, green: 128/255.0, blue: 237/255.0))
            .cornerRadius(50)
            .shadow(color: Color(
                red: 0,
                green: 0,
                blue: 0
            ).opacity(0.5), radius: 4, x: 0, y: 4)
    }
}

public struct BoothSecondaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color(red: 127 / 255.0, green: 127 / 255.0, blue: 127 / 255.0))
            .cornerRadius(50)
            .shadow(color: Color(
                red: 0,
                green: 0,
                blue: 0
            ).opacity(0.25), radius: 4, x: 0, y: 4)
    }
}

public struct BoothTertiaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(#colorLiteral(red:0.2, green: 0.2, blue: 0.2, alpha: 1))
            .background(Color(red: 224 / 255.0, green: 224 / 255.0, blue: 224 / 255.0))
            .cornerRadius(50)
            .shadow(color: Color(
                red: 0,
                green: 0,
                blue: 0
            ).opacity(0.5), radius: 4, x: 0, y: 4)
    }
}
struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button(action: {}, label: { Text("Primary Style") })
                .buttonStyle(BoothPrimaryButtonStyle())

            Button(action: {}, label: { Text("Secondary Style") })
                .buttonStyle(BoothSecondaryButtonStyle())

            Button(action: {}, label: { Text("Tertiary Style") })
                .buttonStyle(BoothTertiaryButtonStyle())
        }
    }
}
