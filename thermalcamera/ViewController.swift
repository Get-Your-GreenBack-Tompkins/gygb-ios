//
//  ViewController.swift
//  thermalcamera
//
//  Created by Ashneel Das on 1/27/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import Firebase
import GoogleSignIn
import UIKit

class ViewController: UIViewController {
    var legalView: LegalView!
    var container: UIView!
    var declineButton: UIButton!
    var acceptButton: UIButton!
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
        view.updateConstraints()
    }

    func emailConstraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor)

        ])
        view.updateConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        view.clipsToBounds = true

        container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.white

        view.addSubview(container)

        emailConstraints()

    }
}
