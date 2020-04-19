//
//  CameraInterface.swift
//  UIFramework
//
//  Created by Evan Welsh on 4/19/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI

public struct CameraInterface: View {
    @Binding var image: Image?
    let capture: (Image) -> Void
    let back: () -> Void

    public init(image: Binding<Image?>,
                capture: @escaping (Image) -> Void,
                back: @escaping () -> Void) {
        _image = image
        self.back = back
        self.capture = capture
    }

    public var body: some View {
        ZStack {
            Group {
                if image != nil {
                    image?.resizable().background(Color.black)
                } else {
                    Text("No Source Detected")
                }
            }
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
                            if let image = self.image {
                                self.capture(image)
                            }
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
                .background(Color.white.opacity(0.95))
            }
        }
    }
}

struct CameraInterface_Previews: PreviewProvider {
    static var bundle = Bundle(path: "org.getyourgreenbacktompkins.UIFramework")
    static var previews: some View {
        CameraInterface(
            image: .constant(
            Image(
                "ImageA",
                bundle: bundle
                )
            ),
            capture: { _ in print("Image Captured!") },
            back: { print("Go Back!") })
    }
}
