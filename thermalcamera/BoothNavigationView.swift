//
//  BoothNavigationView.swift
//  thermalcamera
//
//  Created by Evan Welsh on 4/18/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import UIFramework
import SwiftUI

struct BoothNavigationView: View {
    @EnvironmentObject var session: FirebaseSession

    @State var accepted: Bool = false

    func accept() {
        self.accepted = true
        print("accepted!")
    }

    func decline() {
        print("declined!")
    }

    var body: some View {
        Group {
            if session.user != nil {
                if accepted {
                    BoothSelectionView()
                } else {
                    LegalViewRepresentable(accept: accept, decline: decline)
                }
            } else {
                SigninView()
            }
        }.onAppear(perform: { () -> Void in
            self.session.listen()
        })
    }
}

struct BoothNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BoothNavigationView()
    }
}
