//
//  CaptureReviewView.swift
//  UIFramework
//
//  Created by Evan Welsh on 4/19/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI

public struct CaptureReviewView: View {
    // TODO Should this be a binding?
    @Binding var image: Image?
    @Binding var uiimage: UIImage?
    let discard: () -> Void
    let save: () -> Void

    public init(image: Binding<Image?>,
                uiimage: Binding<UIImage?>,
                discard: @escaping () -> Void,
                save: @escaping () -> Void) {
        _image = image
        _uiimage = uiimage
        self.discard = discard
        self.save = save
    }

    public var body: some View {
        VStack {
            Spacer()

            Group {
                if image != nil {
                    image?.resizable().frame(width: 571, height: 546).background(Color.black).cornerRadius(30)
                } else {
                    Text("No Source Detected")
                }
            }

            HStack(alignment: .bottom) {
                Spacer()
                Button(
                    action: {
                        self.discard()
                    },
                    label: {
                        Text("Discard")
                    }
                )
                .buttonStyle(BoothTertiaryButtonStyle())
                .alignmentGuide(HorizontalAlignment.leading) {
                    (elem) -> CGFloat in elem[HorizontalAlignment.leading]
                }
                .frame(width: 220)

                Spacer()

                Button(
                    action: {
                        self.save()
                    }, label: {
                        Text("Save")
                    }
                )
                .buttonStyle(BoothPrimaryButtonStyle())
                .alignmentGuide(HorizontalAlignment.center) { (elem) -> CGFloat in elem[HorizontalAlignment.center]
                }.frame(width: 220)

                Spacer()
            }
            .padding(.all, 20)

            Spacer()

        }
    }
}

struct CaptureReviewView_Previews: PreviewProvider {
    static var bundle = Bundle(path: "org.getyourgreenbacktompkins.BoothUI")
    static var previews: some View {
        CaptureReviewView(image: .constant(
            Image(
                "ImageA",
                bundle: bundle
            )
            ), uiimage: .constant(UIImage()),
                          discard: { print("Image Discarded!") },
                          save: { print("Save!") })
    }
}
