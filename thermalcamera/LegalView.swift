//
//  EmailView.swift
//  thermalcamera
//
//  Created by Ashneel  Das on 2/14/20.
//  Copyright © 2020 Ashneel  Das. All rights reserved.
//
class LegalView : UIView {
    
    var declineButton : UIButton!
    var acceptButton : UIButton!
    var buttonView : UIView!
    var field : UITextView!
    var titleField : UITextView!
    
    @objc func submit(sender: UIButton!) {
        print("hi")
        sender.setTitleColor(UIColor.blue, for: .normal)
    }
    
    @objc func touchDown(sender: UIButton!) {
        sender.setTitleColor(UIColor.green, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true

        field = UITextView()
        field.clipsToBounds = true
        field.translatesAutoresizingMaskIntoConstraints = false
        field.isScrollEnabled = true
        field.isUserInteractionEnabled = true
        field.isEditable = false
        field.font = .systemFont(ofSize: 25)
        
        field.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam et risus lorem. Aenean at lacus non nunc hendrerit facilisis eget ut metus. In nisl est, mollis vitae arcu eget, vulputate tristique metus. Maecenas vel euismod augue. Suspendisse at orci vulputate, dictum augue vitae, vulputate sapien. Vestibulum eu lacinia sem. Pellentesque erat orci, tempor quis eleifend ut, suscipit sollicitudin neque. Sed iaculis sit amet velit vitae dictum. Etiam diam metus, tempus quis justo ac, consectetur mollis odio. Curabitur a purus blandit, consectetur lectus id, feugiat sem. Cras gravida lacus et magna rhoncus, at fringilla neque laoreet. Etiam tempus leo mi, sed bibendum ligula congue at. Cras aliquet, nisi ut tempor vehicula, dolor ex mollis nunc, non molestie lacus sem vel neque. Suspendisse imperdiet maximus elit, ac iaculis magna accumsan a. Vivamus arcu erat, rhoncus id commodo quis, auctor sit amet massa. Mauris mollis nunc quis semper malesuada. In euismod tortor eu massa vulputate, eget varius arcu semper. Curabitur venenatis justo lectus, a condimentum lorem aliquet a. Quisque non nunc elit. Mauris ultricies ipsum a massa fringilla, eget sagittis nibh mollis. Morbi eu urna convallis, ultricies ante vel, ultricies urna. Maecenas in felis nisl. Suspendisse odio orci, aliquet ac neque at, pellentesque pharetra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Maecenas vel euismod augue. Suspendisse at orci vulputate, dictum augue vitae, vulputate sapien. Vestibulum eu lacinia sem. Pellentesque erat orci, tempor quis eleifend ut, suscipit sollicitudin neque. Sed iaculis sit amet velit vitae dictum. Etiam diam metus, tempus quis justo ac, consectetur mollis odio. Curabitur a purus blandit, consectetur lectus id, feugiat sem. Cras gravida lacus et magna rhoncus, at fringilla neque laoreet. Etiam tempus leo mi, sed bibendum ligula congue at. Cras aliquet, nisi ut tempor vehicula, dolor ex mollis nunc, non molestie lacus sem vel neque. Suspendisse imperdiet maximus elit, ac iaculis magna accumsan a. Vivamus arcu erat, rhoncus id commodo quis, auctor sit amet massa. Mauris mollis nunc quis semper malesuada. In euismod tortor eu massa vulputate, eget varius arcu semper. Curabitur venenatis justo lectus, a condimentum lorem aliquet a. Quisque non nunc elit. Mauris ultricies ipsum a massa fringilla, eget sagittis nibh mollis. Morbi eu urna convallis, ultricies ante vel, ultricies urna. Maecenas in felis nisl. Suspendisse odio orci, aliquet ac neque at, pellentesque pharetra purus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos."
        
        titleField = UITextView()
        titleField.clipsToBounds = true
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.isEditable = false
        titleField.font = UIFont.boldSystemFont(ofSize: 25)
        titleField.text = "Terms of Service"
        
        addSubview(field)
        addSubview(titleField)
        
        NSLayoutConstraint.activate([
            field.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -50),
            field.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -300),
            field.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            field.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -25),
            
            titleField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            titleField.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -470),
            titleField.heightAnchor.constraint(equalToConstant: 40),
            titleField.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -420)
        ])
        updateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
