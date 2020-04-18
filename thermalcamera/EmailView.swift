//
//  EmailView.swift
//  thermalcamera
//
//  Created by Ashneel  Das on 2/14/20.
//  Copyright © 2020 Ashneel  Das. All rights reserved.
//
import Firebase
import GoogleSignIn
import Alamofire

protocol CustomViewProtocol : NSObjectProtocol{
    func buttonTapped()
}

class EmailView : UIView {
    
    var emailField : UITextField!
    var passwordField : UITextField!
    var passRepeatField : UITextField!
    weak var delegate : CustomViewProtocol? = nil
    @IBOutlet var submitButton : UIButton!
    
    
    
    @objc func submit(sender: UIButton!) {
        submitButton.setTitleColor(UIColor.blue, for: .normal)
        self.delegate?.buttonTapped()
//        let emailResult = emailField.text
//        let passwordResult = passwordField.text
//        let parameters = [
//            "email": emailResult,
//            "password": passwordResult,
//            "marketing": true,
//            "source": "ios"
//            ] as [String : Any]
//        AF.request("https://gygb-backend-v1.herokuapp.com/v1/user",
//                          method: .post,
//                          parameters: parameters,
//                          encoding: JSONEncoding.default,
//                          headers: ["Content-Type": "application/json"])
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
        
        passwordField = UITextField()
        passwordField.isSecureTextEntry = true
        passwordField.clipsToBounds = true
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.layer.cornerRadius = 5
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.black.cgColor
        passwordField.placeholder = "Enter password"
        
        passRepeatField = UITextField()
        passRepeatField.isSecureTextEntry = true
        passRepeatField.clipsToBounds = true
        passRepeatField.translatesAutoresizingMaskIntoConstraints = false
        passRepeatField.layer.cornerRadius = 5
        passRepeatField.layer.borderWidth = 1
        passRepeatField.layer.borderColor = UIColor.black.cgColor
        passRepeatField.placeholder = "Confirm password"
    
        

        
        submitButton = UIButton()
        submitButton.clipsToBounds = true
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor.white, for: .normal)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
        submitButton.layer.cornerRadius = 4
        submitButton.layer.borderWidth = 1
        submitButton.layer.backgroundColor = UIColor.systemBlue.cgColor
        submitButton.layer.borderColor = UIColor.black.cgColor
        
        self.addSubview(submitButton)
        self.addSubview(passwordField)
        self.addSubview(emailField)
        
        NSLayoutConstraint.activate([
            emailField.widthAnchor.constraint(equalToConstant: 200),
            emailField.heightAnchor.constraint(equalToConstant: 30),
            emailField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            emailField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -80),
            
            passwordField.widthAnchor.constraint(equalToConstant: 200),
            passwordField.heightAnchor.constraint(equalToConstant: 30),
            passwordField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -40),
    
            
            
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            submitButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0),
        ])
        
        updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
 
}


