//
//    CameraProvider.swift
//    UIFramework
//
//    Created by Evan Welsh on 4/19/20.
//    Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI

public struct SigninView: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var showAlert: Bool
    @Binding var error: Error?

    let login: () -> Void

    public init(
        email: Binding<String>,
        password: Binding<String>,
        showAlert: Binding<Bool>,
        error: Binding<Error?>,
        login: @escaping () -> Void) {
        self._email = email
        self._password = password
        self._showAlert = showAlert
        self._error = error

        self.login = login
    }

    public var body: some View {
        VStack {
            TextField("Enter email here", text: $email).padding(.all, 5)
            SecureField("Enter password", text: $password).padding(.all, 5)

            Button(
                action: {
                    self.login()
                },
                label: {
                    Text("Submit")
                }
            )
            .alert(isPresented: self.$showAlert, content: {
                Alert(title: Text("Error"), message: Text(error?.localizedDescription ?? "Unknown error"),
                                                          dismissButton: .default(Text("OK")))
            })
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView(
            email: .constant("hello@example.com"),
            password: .constant("*******"),
            showAlert: .constant(false),
            error: .constant(nil)
        ) {
            print("Login!")
        }
    }
}
