//
//  PhotoGallery.swift
//  UIFramework
//
//  Created by Evan Welsh on 4/19/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI

public struct PhotoGalleryView: View {
    @State var images: [Image] = []
    private let addPicture: ((Image) -> Void) -> Void

    public init(addPicture: @escaping ((Image) -> Void) -> Void) {
        self.addPicture = addPicture
    }

    public var body: some View {
        GridView(itemCount: images.count, maxItemCount: 4, columnCount: 2,
                 spacing: 20,
                 getItem: { (ind: Int) -> Image in
                     let image = self.images[ind]

                     return image.resizable(resizingMode: Image.ResizingMode.stretch)
                 },
                 addItem: { _ in
                     self.addPicture { image in
                         self.images.append(image)
                     }
                 },
                 deleteItem: { itemIndex in
                     self.images.remove(at: itemIndex)
                 })
    }
}

struct PhotoGallery_Previews: PreviewProvider {
    static var previews: some View {
        PhotoGalleryView { callback in
            let bundle = Bundle(identifier: "org.getyourgreenbacktompkins.UIFramework")

            let image = Image("ImageA", bundle: bundle)

            callback(image)
        }
    }
}
