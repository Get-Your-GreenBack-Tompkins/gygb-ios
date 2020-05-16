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
            let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
            backgroundImage.image = "Backdrop"
            backgroundImage.contentMode =  UIViewContentMode.scaleAspectFill
            self.view.insertSubview(backgroundImage, at: 0)

            // Don't know if any of this will work
            var view = UILabel()
            view.frame = CGRect(x: 0, y: 0, width: 634, height: 378)
            view.backgroundColor = #colorLiteral(red: 0.95686274509, green: 0.95686274509, blue: 0.95686274509, alpha: 1 )
            view.layer.cornerRadius = 30
            var parent = self.view!
            parent.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.widthAnchor.constraint(equalToConstant: 634).isActive = true
            view.heightAnchor.constraint(equalToConstant: 378).isActive = true
            view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 75).isActive = true
            view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 221).isActive = true
            // 

            Image("HotShot").resizable().scaledToFit().frame(width: UIScreen.main.bounds.width - 200, height: 300)

            Button(action: {
                self.accept()
            }, label: { Text("Start") })
                .foregroundColor(UI.white()) //text color
                .padding(.top, 40)
                .frame(width: 540, height: 138)
                .buttonStyle(BoothPrimaryButtonStyle())
                .cornerRadius(35)
               
        }
    }
}
