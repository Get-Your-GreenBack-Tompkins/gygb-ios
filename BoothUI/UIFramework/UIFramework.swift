//
//  ContentView.swift
//  uidev
//
//  Created by Evan Welsh on 4/18/20.
//  Copyright © 2020 Evan Welsh. All rights reserved.
//

import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

func calculateColumnWidth(totalWidth: CGFloat, minimumItemWidth: Int, columnCount: Int, spacing: CGFloat) -> CGFloat {
    let numOfColumns = CGFloat(columnCount)
    let availableWidth = totalWidth - spacing * (numOfColumns + 1)
    let initial = availableWidth / numOfColumns

    if initial < CGFloat(minimumItemWidth) {
        return CGFloat(minimumItemWidth)
    }

    return CGFloat(initial).rounded(FloatingPointRoundingRule.down)
}

public struct GridView<Element>: View where Element: View {
    private let rows: [[Int]]
    private let provider: (Int) -> Element
    private let itemCount: Int
    private let spacing: CGFloat

    init(itemCount: Int, columnCount: Int, spacing: Int, provider: @escaping (Int) -> Element) {
        self.itemCount = itemCount
        self.provider = provider
        self.spacing = CGFloat(spacing)
        let items = Array(0 ..< itemCount)

        rows = items.chunked(into: columnCount)
    }

    public var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading) {
                ForEach(self.rows, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { item in
                            self.provider(item).frame(width: calculateColumnWidth(
                                    totalWidth: geometry.size.width,
                                    minimumItemWidth: 32,
                                    columnCount: 2,
                                    spacing: self.spacing
                                )
                            )
                            }.padding(.horizontal, self.spacing / 2)
                    }
                }.padding(.horizontal, self.spacing / 2)
            }
        }
    }
}

public struct BoothSelectionView: View {
    var images: [Image]

    public init() {
        let bundle = Bundle(identifier: "org.getyourgreenbacktompkins.UIFramework")
        images = [
            Image("ImageA", bundle: bundle),
            Image("ImageB", bundle: bundle),
            Image("ImageC", bundle: bundle)
        ]
    }

    public var body: some View {
        GridView(itemCount: 3, columnCount: 2, spacing: 20, provider: { (ind: Int) -> Image in
            let image = self.images[ind]

            return image.resizable(resizingMode: Image.ResizingMode.stretch)
        })
    }
}

struct BoothSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        BoothSelectionView().frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
    }
}
