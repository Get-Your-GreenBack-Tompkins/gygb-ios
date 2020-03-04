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

    @objc func submit(sender: UIButton!) {
        print("hi")
        sender.setTitleColor(UIColor.blue, for: .normal)
        self.legalView.removeFromSuperview()
        self.acceptButton.removeFromSuperview()
        self.declineButton.removeFromSuperview()
        self.emailView = EmailView()
        self.emailView.translatesAutoresizingMaskIntoConstraints = false
        self.container.addSubview(self.emailView)
        self.emailConstraints()
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

        NSLayoutConstraint.deactivate(legalView.constraints)
        NSLayoutConstraint.deactivate(acceptButton.constraints)
        NSLayoutConstraint.deactivate(declineButton.constraints)
        NSLayoutConstraint.activate([

            emailView.heightAnchor.constraint(equalTo: container.heightAnchor),
            emailView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            emailView.widthAnchor.constraint(equalTo: container.readableContentGuide.widthAnchor),
            emailView.centerYAnchor.constraint(equalTo: container.centerYAnchor)
         ])
        view.updateConstraints()
    }
    
    func legalConstraints() {
        NSLayoutConstraint.deactivate(signinView.constraints)
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
        
        declineButton.setTitle("Decline", for: .normal)
        declineButton.setTitleColor(UIColor.blue, for: .normal)
        declineButton.addTarget(self, action: #selector(self.touchDown), for: .touchDown)
        declineButton.addTarget(self, action: #selector(self.touchUp), for: .touchUpInside)
        declineButton.backgroundColor = UIColor.white
        declineButton.layer.cornerRadius = 5
        declineButton.layer.borderWidth = 1
        declineButton.layer.borderColor = UIColor.black.cgColor

        NSLayoutConstraint.activate([
            
            declineButton.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: -80),
            declineButton.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 150),
            acceptButton.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 80),
            acceptButton.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: 150),
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
        
        signinView = SigninView()
        signinView.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(signinView)
        view.addSubview(container)
        
        signinConstraints()

        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = Auth.auth().currentUser {
                self.signinView.removeFromSuperview()
                NSLayoutConstraint.deactivate(self.signinView.constraints)
                self.legalView = LegalView()
                self.legalView.translatesAutoresizingMaskIntoConstraints = false
                self.container.addSubview(self.legalView)
                self.legalConstraints()
            }
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
