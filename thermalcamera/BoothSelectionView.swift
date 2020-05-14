//
//  PhotoGallery.swift
//  UIFramework
//
//  Created by Evan Welsh on 4/19/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI
import UIFramework

public struct BoothSelectionView: View {
    @State var images: [Image] = []
    @State var uiImages: [UIImage] = []
    @State var pendingImage: Image?
    @State var pendinguiImage: UIImage?
    @State var showCamera: Bool = true
    @State var done: Bool = false
    var emailSent: () -> Void
    @EnvironmentObject var settings: SessionSettings

    public init(emailSent: @escaping () -> Void) {
        self.emailSent = emailSent
    }

    public var body: some View {
        let currentImage = Binding<Image?>(get: {
            return self.pendingImage
        }, set: { image in
            self.pendingImage = image
        })

        let currentuiImage = Binding<UIImage?>(get: {
            return self.pendinguiImage
        }, set: { image in
            self.pendinguiImage = image
        })
        
        return Group {
            if showCamera {
                 ThermalCameraView(isShown: $showCamera, image: currentImage, uiImage: currentuiImage)
//                NativeCameraView(isShown: $showCamera, image: currentImage, uiImage: currentuiImage)
            } else if pendingImage != nil && pendinguiImage != nil {
                CaptureReviewView(image: $pendingImage, uiimage: $pendinguiImage, discard: {
                    self.pendingImage = nil
                    self.pendinguiImage = nil
                    self.showCamera = true
                }, save: {
                    self.showCamera = false

                    if let image = self.pendingImage {
                        self.images.append(image.resizable(resizingMode: Image.ResizingMode.stretch))
                    }
                    if let image = self.pendinguiImage {
                        self.uiImages.append(image)
                    }
                    
                    self.pendingImage = nil
                    self.pendinguiImage = nil
                })
            } else if !self.done {
                VStack {
                    GridView(items: $images, uiitems: $uiImages, maxItemCount: 4, columnCount: 2,
                             spacing: 20,
                             addItem: { _ in
                                 self.showCamera = true
                             },
                             deleteItem: { itemIndex in
                                self.images.remove(at: itemIndex)
                                self.uiImages.remove(at: itemIndex)
                     })
                        .padding(.bottom, 20)
                    Button(action: {
                        self.done = true
                    }, label: {
                        Text("Done")
                    })
                    .frame(width: 130, height: 20)
                    .buttonStyle(BoothPrimaryButtonStyle())
                    .backgroundColor((UIColor(red: 47/255.0, green: 128/255.0, blue: 237/255.0, alpha: 1))
                    .padding(.bottom, 50)
                    .cornerRadius(30)
                }
            }
            else {
                UploadView(images: uiImages, emailSent: emailSent)
                    .environmentObject(self.settings)
            }
        }
    }
}

struct BoothSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        BoothSelectionView(emailSent: {}).frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: Alignment.topLeading
        )
    }
}
