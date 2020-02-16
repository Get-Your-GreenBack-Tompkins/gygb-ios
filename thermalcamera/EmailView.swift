//
//  EmailView.swift
//  thermalcamera
//
//  Created by Ashneel  Das on 2/14/20.
//  Copyright © 2020 Ashneel  Das. All rights reserved.
//
import Firebase
import GoogleSignIn

class EmailView : UIView {
    
    var signInButton : UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true

        print("HELLOOOOO")
        
        signInButton = UIButton()
        signInButton.clipsToBounds = true
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.setTitle("hello", for: .normal)
        signInButton.backgroundColor = UIColor.orange
        
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
