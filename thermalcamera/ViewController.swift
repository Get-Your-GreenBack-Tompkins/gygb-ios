//
//  ViewController.swift
//  thermalcamera
//
//  Created by Ashneel Das on 1/27/20.
//  Copyright © 2020 Ashneel  Das. All rights reserved.
//

import UIKit
import GoogleSignIn
import Firebase

class ViewController: UIViewController
// FLIRDiscoveryEventDelegate, FLIRDataReceivedDelegate
{

    var signinView : SigninView!
    var emailView: EmailView!
    var legalView: LegalView!
    var container : UIView!
    var declineButton : UIButton!
    var acceptButton : UIButton!
    var isPasswordValid = false

    


    @objc func submit(sender: UIButton!) {
        
       sender.setTitleColor(UIColor.blue, for: .normal)
       print("submit")
       let dashboardViewController = DashboardViewController()
       present(dashboardViewController, animated: true, completion: nil)
        
    }
    
    
    @objc func touchUp(sender: UIButton!) {
        sender.setTitleColor(UIColor.blue, for: .normal)
    }
    
    @objc func touchDown(sender: UIButton!) {
        sender.setTitleColor(UIColor.green, for: .normal)
    }
    
    
    func signinConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            signinView.heightAnchor.constraint(equalTo: container.heightAnchor),
            signinView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            signinView.widthAnchor.constraint(equalTo: container.readableContentGuide.widthAnchor),
            signinView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
         ])
        view.updateConstraints()
    }
    
    func emailConstraints() {
        
       //NSLayoutConstraint.deactivate(signinView.constraints)
        //NSLayoutConstraint.deactivate(legalView.constraints)
        //NSLayoutConstraint.deactivate(acceptButton.constraints)
        //NSLayoutConstraint.deactivate(declineButton.constraints)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            emailView.heightAnchor.constraint(equalTo: container.heightAnchor),
            emailView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            emailView.widthAnchor.constraint(equalTo: container.readableContentGuide.widthAnchor),
            emailView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
         ])
        view.updateConstraints()
    }
    
    func legalConstraints() {
            NSLayoutConstraint.deactivate(emailView.constraints)
            declineButton = UIButton()
            acceptButton = UIButton()
            
            declineButton.clipsToBounds = true
            declineButton.translatesAutoresizingMaskIntoConstraints = false

            acceptButton.clipsToBounds = true
            acceptButton.translatesAutoresizingMaskIntoConstraints = false
    //        buttonView.addSubview(signInButton)
            container.addSubview(declineButton)
            container.addSubview(acceptButton)
            
            acceptButton.setTitle("Accept", for: .normal)
            acceptButton.setTitleColor(UIColor.blue, for: .normal)
            acceptButton.addTarget(self, action: #selector(self.submit), for: .touchUpInside)
            acceptButton.addTarget(self, action: #selector(self.touchDown), for: .touchDown)
            acceptButton.backgroundColor = UIColor.white
            acceptButton.layer.cornerRadius = 5
            acceptButton.layer.borderWidth = 1
            acceptButton.layer.borderColor = UIColor.black.cgColor
            acceptButton.layer.backgroundColor = #colorLiteral(red: 0.5382429361, green: 0.7149507403, blue: 0.32184273, alpha: 1)
            acceptButton.setTitleColor(UIColor.white, for: .normal)
            let acceptWidthConstraint = NSLayoutConstraint(item: acceptButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 130)
            let acceptHeightConstraint = NSLayoutConstraint(item: acceptButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60)
            
            declineButton.setTitle("Decline", for: .normal)
            declineButton.setTitleColor(UIColor.blue, for: .normal)
            declineButton.addTarget(self, action: #selector(self.touchDown), for: .touchDown)
            declineButton.addTarget(self, action: #selector(self.touchUp), for: .touchUpInside)
            declineButton.backgroundColor = UIColor.white
            declineButton.layer.cornerRadius = 5
            declineButton.layer.borderWidth = 1
            declineButton.layer.borderColor = UIColor.black.cgColor
            declineButton.layer.backgroundColor = #colorLiteral(red: 0.5382429361, green: 0.7149507403, blue: 0.32184273, alpha: 1)
            declineButton.setTitleColor(UIColor.white, for: .normal)
            let declineWidthConstraint = NSLayoutConstraint(item: declineButton, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 130)
            let declineHeightConstraint = NSLayoutConstraint(item: declineButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60)
                
            NSLayoutConstraint.activate([
                acceptWidthConstraint,
                declineWidthConstraint,
                acceptHeightConstraint,
                declineHeightConstraint,
                declineButton.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: -80),
                declineButton.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 400),
                acceptButton.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 80),
                acceptButton.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 400),
            ])
            NSLayoutConstraint.activate([

                legalView.heightAnchor.constraint(equalTo: container.heightAnchor),
                legalView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
                legalView.widthAnchor.constraint(equalTo: container.readableContentGuide.widthAnchor),
                legalView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
             ])
            view.updateConstraints()
        }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance().disconnect()
        GIDSignIn.sharedInstance().signIn()
        view.clipsToBounds = true
        
        container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.white
        
        //signinView = SigninView()
        //signinView.translatesAutoresizingMaskIntoConstraints = false
        
        //container.addSubview(signinView)
        //view.addSubview(container)
        //nav bar
        


        
        
        
        emailView = EmailView()
        
        //signinConstraints()
        
        emailView.translatesAutoresizingMaskIntoConstraints = false
        
        emailView.delegate = self 
        
        container.addSubview(emailView)
        view.addSubview(container)
        
        emailConstraints()

        
        configureTextFields()
        
        
//         Auth.auth().createUser(withEmail: "ijc22@cornell.edu", password: "Cornell2020") { authResult, error in
//           // ...
//         }

        
    }
    
    func configureTextFields(){
        emailView.emailField.delegate = self;
        emailView.passwordField.delegate = self;
    }
    
    @objc func btn_clicked(_ sender: UIBarButtonItem) {
        // Do something
    }
    
    

    func validateEmail(email: String?) -> String? {
         guard let trimmedText = email?.trimmingCharacters(in: .whitespacesAndNewlines) else { return nil }
         guard let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue) else { return nil }
         
         let range = NSMakeRange(0, NSString(string: trimmedText).length)
         let allMatches = dataDetector.matches(in: trimmedText,
                                               options: [],
                                               range: range)
         
         if allMatches.count == 1,
             allMatches.first?.url?.absoluteString.contains("mailto:") == true {
             return trimmedText
         } else {
             let alertController = UIAlertController(title: "Error", message: "Please enter a valid email address.", preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
             alertController.addAction(defaultAction)
             self.present(alertController, animated: true, completion: nil)
             return nil
         }
     }

     func validatePassword(password: String?) -> String? {
         var errorMsg = "Password requires at least "
         
        if let txt = emailView.passwordField.text {
             if (txt.rangeOfCharacter(from: CharacterSet.uppercaseLetters) == nil) {
                 errorMsg += "one upper case letter"
             }
             if (txt.rangeOfCharacter(from: CharacterSet.lowercaseLetters) == nil) {
                 errorMsg += ", one lower case letter"
             }
             if (txt.rangeOfCharacter(from: CharacterSet.decimalDigits) == nil) {
                 errorMsg += ", one number"
             }
             if txt.count < 8 {
                 errorMsg += ", and eight characters"
             }
         }
         
         if isPasswordValid {
             return password!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
         } else {
             let alertController = UIAlertController(title: "Password Error", message: errorMsg, preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
             alertController.addAction(defaultAction)
             self.present(alertController, animated: true, completion: nil)
             return nil
         }
     }

//    func cameraFound(_ cameraIdentity: FLIRIdentity) {
//
//    }
//
//    func onConnectionStatusChanged(_ camera: FLIRCamera, status: FLIRConnectionStatus, withError error: Error?) {
//
//    }
//
//    func cameraLost(_ cameraIdentity: FLIRIdentity) {
//        // TODO: Handle camera loss.
//    }
//
//    func imageReceived() {
//
//    }
//
//    func discoveryFinished(_ iface: FLIRCommunicationInterface) {
//        print("discoveryFinished!")
//    }
//
//    func discoveryError(_ error: String, netServiceError nsnetserviceserror: Int32, on iface: FLIRCommunicationInterface) {
//        // TODO: Handle discover errors.
//        print("discoveryError!")
//    }
}

//Function to update the view when text fields get updated
extension ViewController: UITextFieldDelegate {
    func checkEnteredText(_ textField: UITextField){
        if (textField==emailView.emailField){
            validateEmail(email: textField.text)
        } else {
            validatePassword(password: textField.text)
        }
    }
}



extension ViewController : CustomViewProtocol {
    func buttonTapped() {
        Auth.auth().signIn(withEmail: emailView.emailField.text!, password: emailView.passwordField.text!) { (user, error) in
           if error == nil{
             print("hiw")
             self.emailView.removeFromSuperview()
             self.legalView = LegalView()
             self.legalView.translatesAutoresizingMaskIntoConstraints = false
             self.container.addSubview(self.legalView)
             self.view.addSubview(self.container)
             self.legalConstraints()
            
           }else{
             print("hiw")
             let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
             let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                            
              alertController.addAction(defaultAction)
              self.present(alertController, animated: true, completion: nil)
                 }
        }
    }
}
