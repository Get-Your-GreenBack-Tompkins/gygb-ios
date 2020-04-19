//
//  FirebaseUser.swift
//  thermalcamera
//
//  Created by Evan Welsh on 4/18/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import Foundation

struct FirebaseUser {
    var uid: String
    var email: String?

    init(uid: String, email: String?) {
        self.uid = uid
        self.email = email
    }
}
