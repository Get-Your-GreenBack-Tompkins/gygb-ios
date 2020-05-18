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

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

struct CheckView: View {
    @Binding var isChecked:Bool?
    var title: String = "Get Additional Emails from GYGB about Green Living"
    
    init(checked: Binding<Bool?>) {
        _isChecked = checked
    }
    
    func toggle(){
        isChecked = !isChecked!
    }
    var body: some View {
        Button(action: toggle){
            HStack{
                Image(systemName: isChecked! ? "checkmark.square": "square")
                Text(title).foregroundColor(Color.black)
                                    .font(.system(size: 20))
            }
        }
    }

}
struct UploadView: View {
    
    @EnvironmentObject var settings: SessionSettings
    var images: [UIImage]
    @State var email : String = ""
    @State var checked: Bool? = false
    var emailSent: () -> Void
    var uploadDone: () -> Void
    @State var sendingText: String = ""
    
    init(images: [UIImage], emailSent: @escaping () -> Void, uploadDone: @escaping () -> Void) {
        self.images = images
        self.emailSent = emailSent
        self.uploadDone = uploadDone
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
                    .padding(.bottom, 80)
                VStack {
                    HStack {
                        ForEach(Array(0...self.images.count - 1), id: \.self) { index in
                            Image(uiImage: self.images[index]).resizable()
                            .frame(width: 150, height: 150)
                            .cornerRadius(5)
                        }
                    }
                    .padding(.bottom, 20)
                    TextField("Enter your email!", text: $email)
                        .frame(width: 200, height: 40, alignment: .center)
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    CheckView(checked: $checked)
                    Text("""
We never spam. We're here to serve you!

Our only purpose is to provide you with
key information that can help you save
money and live more environmentally.
""")
                        .frame(width: 320, height: 120)
                    Button(action: {
                        self.sendingText = "Sending photo..."
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
                            self.uploadDone()
                        }
                    }, label: {
                        Text("Send Photos")
                    })
                        .padding(.top, 80)
                    .frame(width: 220, height: 15)
                    .buttonStyle(BoothPrimaryButtonStyle())
                }
                .padding(.top, 50)
                Text("\(sendingText)").padding(.top, 50).padding(.bottom, 330)
            }.padding(.top, 100))
    }
}
