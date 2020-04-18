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

        NSLayoutConstraint.deactivate(signinView.constraints)
        NSLayoutConstraint.activate([

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
        
        signinView = SigninView()
        signinView.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(signinView)
        view.addSubview(container)
        
        signinConstraints()

        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = Auth.auth().currentUser {
                self.signinView.removeFromSuperview()
                self.emailView = EmailView()
                self.emailView.translatesAutoresizingMaskIntoConstraints = false
                self.container.addSubview(self.emailView)
                self.emailConstraints()
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
