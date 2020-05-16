//
//  CameraInterface.swift
//  UIFramework
//
//  Created by Evan Welsh on 4/19/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI

public struct CameraInterface<Stream>: View where Stream: View {
    let capture: () -> Void
    let back: () -> Void
    let stream: () -> Stream

    public init(capture: @escaping () -> Void,
                back: @escaping () -> Void,
                @ViewBuilder stream: @escaping () -> Stream) {
        self.back = back
        self.capture = capture
        self.stream = stream
    }

    public var body: some View {
        ZStack {
            stream()

            VStack {
                Spacer()
                HStack(alignment: .bottom) {
                    Button(
                        action: {
                            self.back()
                        },
                        label: {
                            Image(systemName: "chevron.left")
                        }
                    )
                    .buttonStyle(BoothSecondaryButtonStyle())
                    .alignmentGuide(HorizontalAlignment.leading) {
                        (elem) -> CGFloat in elem[HorizontalAlignment.leading]
                    }
                    .frame(width: 80)

                    Spacer()

                    Button(
                        action: {
                            self.capture()
                        }, label: {
                            Image(systemName: "camera.fill")
                        }
                    )
                    .buttonStyle(BoothPrimaryButtonStyle())
                    .alignmentGuide(HorizontalAlignment.center) { (elem) -> CGFloat in elem[HorizontalAlignment.center]
                    }.frame(width: 120)

                    Spacer()
                    Spacer().frame(width: 80)
                }
                .padding(.all, 20)
                .background(Color((red: 0.2, green: 0.2, blue: 0.2, alpha: 0.7).cgColor))
            }
        }
    }
}

struct CameraInterface_Previews: PreviewProvider {
    static var bundle = Bundle(path: "org.getyourgreenbacktompkins.UIFramework")
    static var previews: some View {
        CameraInterface(
            capture: { print("Image Captured!") },
            back: { print("Go Back!") }) {
                Image(
                    "ImageA",
                    bundle: bundle
                    )
        }
    }
}
