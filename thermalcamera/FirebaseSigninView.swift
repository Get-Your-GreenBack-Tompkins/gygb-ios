//
//  FirebaseSigninView.swift
//  thermalcamera
//
//  Created by Ashneel Das on 2/14/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//
import SwiftUI
import UIFramework

struct FirebaseSigninView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var showAlert: Bool = false
    @State var error: Error?

    @EnvironmentObject var session: FirebaseSession

    func login () {
        session.signIn(email: email, password: password) { (_, error) in
            if error != nil {
                self.error = error
                self.showAlert = true
            } else {
                self.showAlert = false
                self.error = nil
                self.email = ""
                self.password = ""
            }
        }
    }

    var body: some View {
        SigninView(email: $email,
                   password: $password,
                   showAlert: $showAlert,
                   error: $error) {
            self.login()
        }
    }
}
