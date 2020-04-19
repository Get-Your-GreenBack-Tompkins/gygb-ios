//
//  Buttons.swift
//  UIFramework
//
//  Created by Evan Welsh on 4/19/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI


public struct BoothPrimaryButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(Color(red: 144 / 255.0, green: 205 / 255.0, blue: 78 / 255.0))
            .cornerRadius(50)
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
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Button(action: {}) {
                Text("Primary Style")
            }.buttonStyle(BoothPrimaryButtonStyle())
        
            Button(action: {}) {
                Text("Secondary Style")
            }.buttonStyle(BoothSecondaryButtonStyle())
        }
    }
}
