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
    @State var pendingImage: Image?
    @State var showCamera: Bool = false

    public init() {}

    public var body: some View {
        let currentImage = Binding<Image?>(get: {
            return self.pendingImage
        }, set: { image in
            self.pendingImage = image
        })

        return Group {
            if showCamera {
                 ThermalCameraView(isShown: $showCamera, image: currentImage)
//                NativeCameraView(isShown: $showCamera, image: currentImage)
            } else if pendingImage != nil {
                CaptureReviewView(image: $pendingImage, discard: {
                    self.pendingImage = nil
                    self.showCamera = true
                }, save: {
                    self.showCamera = false

                    if let image = self.pendingImage {
                        self.images.append(image.resizable(resizingMode: Image.ResizingMode.stretch))
                    }

                    self.pendingImage = nil
                })
            } else {
                GridView(items: $images, maxItemCount: 4, columnCount: 2,
                         spacing: 20,
                         addItem: { _ in
                             self.showCamera = true
                         },
                         deleteItem: { itemIndex in
                             self.images.remove(at: itemIndex)
                 })
            }
        }
    }
}

struct BoothSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        BoothSelectionView().frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: Alignment.topLeading
        )
    }
}
