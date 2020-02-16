//
//  EmailView.swift
//  thermalcamera
//
//  Created by Ashneel  Das on 2/14/20.
//  Copyright © 2020 Ashneel  Das. All rights reserved.
//
import Firebase
import GoogleSignIn

class SigninView : UIView {
    
    var buttonView : UIView!
    var signInButton : GIDSignInButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        
//        buttonView = UIView()
//        buttonView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton = GIDSignInButton()
        signInButton.clipsToBounds = true
        signInButton.translatesAutoresizingMaskIntoConstraints = false

//        buttonView.addSubview(signInButton)
        addSubview(signInButton)
        NSLayoutConstraint.activate([
            
            signInButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            signInButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
        
        updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
