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
    var container : UIView!
    
    
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
        
        
        //signinConstraints()
        
        
        emailView = EmailView()
        emailView.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(emailView)
        view.addSubview(container)
        
        emailConstraints()
        
        configureTextFields()

    
        
    }
    
    func configureTextFields(){
        emailView.emailField.delegate = self;
        emailView.passwordField.delegate = self;
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
