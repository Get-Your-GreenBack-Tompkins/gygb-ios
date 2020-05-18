//
//  BoothNavigationView.swift
//  thermalcamera
//
//  Created by Evan Welsh on 4/18/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import UIFramework
import SwiftUI
import Alamofire

class SessionSettings: ObservableObject {
    @Published var sessionid = ""
}

struct BoothNavigationView: View {
    @EnvironmentObject var session: FirebaseSession
    var settings = SessionSettings()
    @State var accepted: Bool = false
    @State var welcomeaccepted: Bool = false
    
    func accept() {
        let dateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd")
        let parameters = [
            "email": "",
            "downloaded": false,
            "startTime": dateFormatter.string(from: date),
            "endTime": nil
            ] as [String : Any?]
        AF.request(
            "https://gygb-backend-v1.herokuapp.com/v1/session/create",
            method: .post,
            parameters: parameters as Parameters,
            encoding: JSONEncoding.default,
            headers: ["Content-Type": "application/json"])
            .responseString { response in
                self.settings.sessionid = String(data: response.data!, encoding: .utf8)!
                self.accepted = true
                print(self.settings.sessionid)
            }
//        self.accepted = true 
    }

    func decline() {
        self.welcomeaccepted = false
    }

    func emailSent() {
        self.accepted = false
        self.welcomeaccepted = false
    }
    
    func welcomeAccept() {
        self.welcomeaccepted = true
    }
    
    var body: some View {
        Group {
            if session.user != nil {
                if accepted {
                    BoothSelectionView(emailSent: emailSent)
                    .environmentObject(self.settings)

                } else if welcomeaccepted {
                    LegalViewRepresentable(accept: accept, decline: decline)
                } else {
                    WelcomeView(welcomeAccept: welcomeAccept)
                }
            } else {
                SigninView()
            }
        }.onAppear(perform: { () -> Void in
            self.session.listen()
        })
    }
}

struct BoothNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        BoothNavigationView()
    }
}
