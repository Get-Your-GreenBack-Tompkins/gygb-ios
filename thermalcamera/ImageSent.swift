//
//  ImageSent.swift
//  thermalcamera
//
//  Created by Ashneel  Das on 5/14/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI
import UIFramework

struct ImageSent: View {
    
    var emailSent: () -> Void

    
    init(emailSent: @escaping () -> Void) {
        self.emailSent = emailSent
    }
    
    public var body : some View {
        return (
            VStack {
                Text("Your image has been sent!")
                    .padding(.bottom, 50)
                Button(action: {
                    self.emailSent()
                }, label: {
                    Text("Restart")
                })
                .frame(width: 220, height: 15)
                .buttonStyle(BoothPrimaryButtonStyle())
            }
        )
    }
}
