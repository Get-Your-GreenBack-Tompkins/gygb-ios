//
//  EmailView.swift
//  thermalcamera
//
//  Created by Ashneel Das on 2/14/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI

struct LegalViewRepresentable: UIViewRepresentable {
    var accept: () -> Void
    var decline: () -> Void
    @EnvironmentObject var settings: SessionSettings

    init(accept: @escaping () -> Void, decline: @escaping () -> Void) {
        self.accept = accept
        self.decline = decline
    }

    func updateUIView(_: LegalView, context _: Context) {
        print("updating...")
    }

    func makeUIView(context _: Context) -> LegalView {
        let view = LegalView(frame: .zero)
        view.onAccept {
            self.accept()
        }
        view.onDecline {
            self.decline()
        }
        return view
    }
}

class LegalView: UIView {
    var declineButton: UIButton!
    var acceptButton: UIButton!
    var buttonView: UIView!
    var field: UITextView!
    var titleField: UITextView!

    var accept: (() -> Void)?
    var decline: (() -> Void)?

    @objc func acceptTouchUp(sender: UIButton!) {
        sender.setTitleColor(UIColor.blue, for: .normal)

        if let callback = accept {
            callback()
        }
    }

    @objc func declineTouchUp(sender: UIButton!) {
        sender.setTitleColor(UIColor.blue, for: .normal)

        if let callback = decline {
            callback()
        }
    }

    @objc func touchDown(sender: UIButton!) {
        sender.setTitleColor(UIColor.green, for: .normal)
    }

    func onAccept(callback: @escaping () -> Void) {
        accept = callback
    }

    func onDecline(callback: @escaping () -> Void) {
        decline = callback
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true

        field = UITextView()
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        field.text = """
        By using this app, you agree to the following terms:
        
        • Temporary storage of images for the shorter of 30 days or until time of download.
        • Granting access to your email address for delivery of thermal photos.
        """
        field.isScrollEnabled = true
        field.isUserInteractionEnabled = true
        field.isEditable = false
        field.font = .systemFont(ofSize: 25)

        titleField = UITextView()
        titleField.clipsToBounds = true
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.isEditable = false
        titleField.font = UIFont.boldSystemFont(ofSize: 25)
        titleField.text = "Terms of Service"
        titleField.isScrollEnabled = false
        
        addSubview(field)
        addSubview(titleField)

        NSLayoutConstraint.activate([
            field.widthAnchor.constraint(equalTo: widthAnchor, constant: -50),
            field.heightAnchor.constraint(equalTo: heightAnchor, constant: -300),
            field.centerXAnchor.constraint(equalTo: centerXAnchor),
            field.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -25),

            titleField.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 57),
            titleField.widthAnchor.constraint(equalTo: widthAnchor, constant: -470),
            titleField.heightAnchor.constraint(equalToConstant: 40),
            titleField.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -420),
        ])

        declineButton = UIButton()
        acceptButton = UIButton()
        declineButton.clipsToBounds = true
        declineButton.translatesAutoresizingMaskIntoConstraints = false

        acceptButton.clipsToBounds = true
        acceptButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(declineButton)
        addSubview(acceptButton)

        acceptButton.setTitle("Accept", for: .normal)
        acceptButton.setTitleColor(UIColor.blue, for: .normal)
        acceptButton.addTarget(self, action: #selector(acceptTouchUp), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
        acceptButton.backgroundColor = UIColor.white
        acceptButton.layer.cornerRadius = 5
        acceptButton.layer.borderWidth = 1
        acceptButton.layer.borderColor = UIColor.black.cgColor
        acceptButton.layer.backgroundColor = #colorLiteral(red: 0.5382429361, green: 0.7149507403, blue: 0.32184273, alpha: 1)
        acceptButton.setTitleColor(UIColor.white, for: .normal)
        let acceptWidthConstraint =
            NSLayoutConstraint(item: acceptButton, attribute: NSLayoutConstraint.Attribute.width,
                               relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                               multiplier: 1, constant: 130)
        let acceptHeightConstraint =
            NSLayoutConstraint(item: acceptButton, attribute: NSLayoutConstraint.Attribute.height,
                               relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                               multiplier: 1, constant: 60)

        declineButton.setTitle("Decline", for: .normal)
        declineButton.setTitleColor(UIColor.blue, for: .normal)
        declineButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
        declineButton.addTarget(self, action: #selector(declineTouchUp), for: .touchUpInside)
        declineButton.backgroundColor = UIColor.white
        declineButton.layer.cornerRadius = 5
        declineButton.layer.borderWidth = 1
        declineButton.layer.borderColor = UIColor.black.cgColor
        declineButton.layer.backgroundColor = #colorLiteral(red: 0.5382429361, green: 0.7149507403, blue: 0.32184273, alpha: 1)
        declineButton.setTitleColor(UIColor.white, for: .normal)
        let declineWidthConstraint = NSLayoutConstraint(item: declineButton, attribute: NSLayoutConstraint.Attribute.width,
                                                        relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 130)
        let declineHeightConstraint = NSLayoutConstraint(item: declineButton, attribute: NSLayoutConstraint.Attribute.height,
                                                         relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 60)

        NSLayoutConstraint.activate([
            acceptWidthConstraint,
            declineWidthConstraint,
            acceptHeightConstraint,
            declineHeightConstraint,
            declineButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -80),
            declineButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 400),
            acceptButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 80),
            acceptButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 400),
        ])

        updateConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
