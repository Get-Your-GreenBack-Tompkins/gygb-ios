//
//  EmailView.swift
//  thermalcamera
//
//  Created by Ashneel Das on 2/14/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI
import Alamofire

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
        view.background(Color(red: 0.95686274509, green: 0.95686274509, blue: 0.95686274509, alpha: 1)))

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
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor(#colorLiteral(red: 0.18431372549, green: 0.50196078431, blue: 0.9294117647, alpha: 1))

        if let callback = accept {
            callback()
        }
    }

    @objc func declineTouchUp(sender: UIButton!) {
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor(#colorLiteral(red: 0.18431372549, green: 0.50196078431, blue: 0.9294117647, alpha: 1))


        if let callback = decline {
            callback()
        }
    }

    @objc func touchDown(sender: UIButton!) {
        sender.setTitleColor(UIColor.white, for: .normal)
        sender.backgroundColor(#colorLiteral(red: 0.36862745098, green:0.69019607843, blue:0.87450980392, alpha: 1))
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
        AF.request("https://gygb-backend-v1.herokuapp.com/v1/tos/hotshot", method: .get)
            .responseJSON {response in
                if let data = response.data {
                    let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                    let htmlData = NSString(string: (json?["text"])!).data(using: String.Encoding.unicode.rawValue)
                    let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html]
                    let attributedString = try! NSAttributedString(data: htmlData!, options: options, documentAttributes: nil)
                    self.field.attributedText = attributedString
                    self.field.font = .systemFont(ofSize: 25)
                }
        }
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isScrollEnabled = true
        field.isUserInteractionEnabled = true
        field.isEditable = false
        field.textColor = #colorLiteral(red:0.2, green: 0.2, blue: 0.2, alpha: 1)


        titleField = UITextView()
        titleField.clipsToBounds = true
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.isEditable = false
        titleField.font = UIFont.boldSystemFont(ofSize: 25)
        titleField.text = "Terms of Service"
        titleField.isScrollEnabled = false
        titleField.textColor = #colorLiteral(red:0.2, green: 0.2, blue: 0.2, alpha: 1)
        
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
        acceptButton.addTarget(self, action: #selector(acceptTouchUp), for: .touchUpInside)
        acceptButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
        acceptButton.backgroundColor = #colorLiteral(red: 0.18431372549, green: 0.50196078431, blue: 0.9294117647, alpha: 1)
        acceptButton.layer.backgroundColor = #colorLiteral(red: 0.18431372549, green: 0.50196078431, blue: 0.9294117647, alpha: 1)
        acceptButton.layer.cornerRadius = 10
        acceptButton.setTitleColor(UIColor.white, for: .normal)
        acceptButton.foregroundColor(.white)

        let acceptWidthConstraint =
            NSLayoutConstraint(item: acceptButton, attribute: NSLayoutConstraint.Attribute.width,
                               relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                               multiplier: 1, constant: 130)
        let acceptHeightConstraint =
            NSLayoutConstraint(item: acceptButton, attribute: NSLayoutConstraint.Attribute.height,
                               relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                               multiplier: 1, constant: 60)

        declineButton.setTitle("Decline", for: .normal)
        declineButton.setTitleColor(UIColor.white, for: .normal)
        declineButton.addTarget(self, action: #selector(touchDown), for: .touchDown)
        declineButton.addTarget(self, action: #selector(declineTouchUp), for: .touchUpInside)
        declineButton.backgroundColor = #colorLiteral(red: 0.18431372549, green: 0.50196078431, blue: 0.9294117647, alpha: 1)
        declineButton.layer.backgroundColor = #colorLiteral(red: 0.18431372549, green: 0.50196078431, blue: 0.9294117647, alpha: 1)
        declineButton.layer.cornerRadius = 10
        declineButton.foregroundColor(.white)
    
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
