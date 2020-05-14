//
//  UploadView.swift
//  UIFramework
//
//  Created by Ashneel  Das on 4/26/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI
import Alamofire
import UIFramework
import FirebaseStorage
import ZIPFoundation

struct UploadView: View {
    
    @EnvironmentObject var settings: SessionSettings
    var images: [UIImage]
    @State var email : String = ""
    var emailSent: () -> Void
    
    init(images: [UIImage], emailSent: @escaping () -> Void) {
        self.images = images
        self.emailSent = emailSent
    }
    
    func archiveData() -> Data {
        let archive = Archive(accessMode: .create)
        for index in 0...self.images.count - 1 {
            let imageData:Data = self.images[index].pngData()!
            try? archive?.addEntry(with: "\(index).png", type: .file, uncompressedSize: UInt32(NSData(data: imageData).length), provider: { (position, size) -> Data in
                return imageData.subdata(in: position..<position+size)
            })
        }
        return archive?.data ?? Data()
    }
    
    public var body : some View {
        return (
            VStack {
                Text("Send your images to yourself!")
                    .bold()
                    .font(.system(size: 25))
                    .padding(.bottom, 250)
                VStack {
                    HStack {
                        ForEach(Array(0...self.images.count - 1), id: \.self) { index in
                            Image(uiImage: self.images[index]).resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(5)
                        }
                    }
                    TextField("Enter your email!", text: $email)
                        .frame(width: 150, height: 30, alignment: .center)
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                        .textColor(UIColor(red:51/255.0 , green:51/255.0, blue:51/255.0, alpha: 1))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .borderWidth(2)
                        .borderColor(UIColor(red:51/255.0 , green:51/255.0, blue:51/255.0, alpha: 1))
                    Button(action: {
                        let dateFormatter = DateFormatter()
                        let date = Date()
                        print("hi")
                        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
                        AF.request(
                            "https://gygb-backend-v1.herokuapp.com/v1/session/update",
                            method: .post,
                            parameters: [
                                "id": self.settings.sessionid,
                                "email": self.email,
                                "endTime": dateFormatter.string(from: date),
                            ],
                            encoding: JSONEncoding.default,
                            headers: ["Content-Type": "application/json"])
                            .response{ response in }
                        AF.request(
                            "https://gygb-backend-v1.herokuapp.com/v1/user",
                            method: .post,
                            parameters: [
                                "email": self.email,
                                "marketing": true,
                                "source": "ios"
                            ],
                            encoding: JSONEncoding.default,
                            headers: ["Content-Type": "application/json"]
                        )
                            .response { response in }
                        let storage = Storage.storage()
                    
                        let data = self.archiveData()
                        let storageRef = storage.reference().child("\(self.settings.sessionid).zip")
                        storageRef.putData(data, metadata: nil) { (metadata, error) in
                            if (error != nil) {
                                print("error")
                            }
                            self.emailSent()
                        }
                    }, label: {
                        Text("Send Photos")
                    })
                    .padding()
                    .frame(width: 120, height: 15)
                    // .buttonStyle(BoothPrimaryButtonStyle())
                    .backgroundColor((UIColor(red: 47/255.0, green: 128/255.0, blue:237255.0, alpha:1))
                    .foregroundColor(UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1))
                }.padding(.bottom, 400)
        })
    }
}
