//
//  SubscribeView.swift
//  thermalcamera
//
//  Created by Ashneel  Das on 4/18/20.
//  Copyright © 2020 Ashneel  Das. All rights reserved.
//
import Firebase
import GoogleSignIn
import Alamofire

class SubscribeView : UIView {
    
    var emailField : UITextField!
    var submitButton : UIButton!
    
    @objc func submit(sender: UIButton!) {
        submitButton.setTitleColor(UIColor.blue, for: .normal)
        let emailResult = emailField.text
        let parameters = [
            "email": emailResult,
            "marketing": true,
            "source": "ios"
            ] as [String : Any]
        Alamofire.request("https://gygb-backend-v1.herokuapp.com/v1/user",
                          method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type": "application/json"])
    }
    
    @objc func touchDown(sender: UIButton!) {
        sender.setTitleColor(UIColor.green, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        
        emailField = UITextField()
        emailField.clipsToBounds = true
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.layer.cornerRadius = 5
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.placeholder = "Enter email here"
        
        submitButton = UIButton()
        submitButton.clipsToBounds = true
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor.blue, for: .normal)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
        submitButton.backgroundColor = UIColor.white
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.black.cgColor
        
        addSubview(submitButton)
        addSubview(emailField)
        
        NSLayoutConstraint.activate([
            emailField.widthAnchor.constraint(equalToConstant: 200),
            emailField.heightAnchor.constraint(equalToConstant: 30),
            emailField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10),
            
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            submitButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 30),
        ])
        
        updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
