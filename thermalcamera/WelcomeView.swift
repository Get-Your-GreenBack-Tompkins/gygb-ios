//
//  WelcomeView.swift
//  thermalcamera
//
//  Created by Ashneel  Das on 4/29/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import Foundation
import SwiftUI
import UIFramework

struct WelcomeView: View {
    
    var accept : () -> Void
    
    init(welcomeAccept: @escaping () -> Void ) {
        self.accept = welcomeAccept
    }
    
    public var body: some View {
        return VStack {
            Image("GYGBlogo").resizable().scaledToFit().frame(width: UIScreen.main.bounds.width - 200, height: 300)
            Button(action: {
                self.accept()
            }, label: { Text("Start") })
                .padding(.top, 40)
                .frame(width: 120, height: 15)
                .buttonStyle(BoothPrimaryButtonStyle())
        }
    }
}
