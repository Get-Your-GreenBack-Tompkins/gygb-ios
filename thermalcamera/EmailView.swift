//
//  EmailView.swift
//  thermalcamera
//
//  Created by Ashneel Das on 2/14/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//
import Firebase
import GoogleSignIn

class EmailView: UIView {
    var emailField: UITextField!
    var submitButton: UIButton!

    @objc func submit(sender _: UIButton!) {
        submitButton.setTitleColor(UIColor.blue, for: .normal)
    }

    @objc func touchDown(sender: UIButton!) {
        sender.setTitleColor(UIColor.green, for: .normal)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true

        emailField = UITextField()
        emailField.clipsToBounds = true
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.layer.cornerRadius = 5
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)

        submitButton = UIButton()
        submitButton.clipsToBounds = true
        submitButton.translatesAutoresizingMaskIntoConstraints = false

        submitButton.setTitle("Submit", for: .normal)
        submitButton.setTitleColor(UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1), for: .normal)
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        submitButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
        submitButton.backgroundColor = UIColor(red: 47/255.0, green: 128/255.0, blue: 237/255.0, alpha: 1) 
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1)

        addSubview(submitButton)
        addSubview(emailField)

        NSLayoutConstraint.activate([
            emailField.widthAnchor.constraint(equalToConstant: 200),
            emailField.heightAnchor.constraint(equalToConstant: 30),
            emailField.centerXAnchor.constraint(equalTo: centerXAnchor),
            emailField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),

            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            submitButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 30)
        ])

        updateConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
