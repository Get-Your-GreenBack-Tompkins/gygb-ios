//
//  FirebaseSession.swift
//  thermalcamera
//
//  Created by Evan Welsh on 4/18/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import Combine
import Firebase
import Foundation
import SwiftUI

class FirebaseSession: ObservableObject {
    @Published var user: FirebaseUser?
    var handle: AuthStateDidChangeListenerHandle?

    init(user: FirebaseUser? = nil) {
        self.user = user
    }

    deinit {
        disconnect()
    }

    func listen() {
        handle = Auth.auth().addStateDidChangeListener { _, user in
            print("Listening!")
            if let user = user {
                self.user = FirebaseUser(
                    uid: user.uid,
                    email: user.email
                )
            } else {
                self.user = nil
            }
        }
    }

    func signIn(
        email: String,
        password: String,
        callback: @escaping AuthDataResultCallback
    ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: callback)
    }

    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }

    func disconnect() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
