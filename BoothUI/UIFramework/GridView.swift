//
//  GridView.swift
//  UIFramework
//
//  Created by Evan Welsh on 4/19/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

struct BoothAddItemBackgroundStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(
                Color(red: 127 / 255.0, green: 127 / 255.0, blue: 127 / 255.0)
            )
            .background(
                Color(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0)
            )
            .cornerRadius(50)
            .padding(.horizontal, 30)
            .shadow(color: Color(
                red: 0,
                green: 0,
                blue: 0
            ).opacity(0.25), radius: 4, x: 0, y: 4)
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

struct InternalGridView<Element>: View where Element: View {
    private let itemWidth: CGFloat
    private let rows: [[Int]]
    private let itemCount: Int
    private let maxItemCount: Int
    private let getItem: (Int) -> Element
    private let addItem: (Int) -> Void
    private let deleteItem: (Int) -> Void
    private let spacing: CGFloat

    init(itemWidth: CGFloat,
         spacing: CGFloat,
         getItem: @escaping (Int) -> Element,
         addItem: @escaping (Int) -> Void,
         deleteItem: @escaping (Int) -> Void,
         rows: [[Int]],
         itemCount: Int,
         maxItemCount: Int) {
        self.itemWidth = itemWidth
        self.getItem = getItem
        self.addItem = addItem
        self.spacing = spacing
        self.rows = rows
        self.itemCount = itemCount
        self.maxItemCount = maxItemCount
        self.deleteItem = deleteItem
    }

    func addButton(index: Int) -> some View {
        Button(action: {
            self.addItem(index)
        }) {
            Image(systemName: "plus")
                .font(.largeTitle)
                .foregroundColor(
                    Color(
                        red: 127 / 255.0,
                        green: 127 / 255.0,
                        blue: 127 / 255.0
                    )
                )
        }
        .frame(width: itemWidth)
        .buttonStyle(BoothAddItemBackgroundStyle())
    }

    func buildRow(row: [Int]) -> some View {
        HStack {
            ForEach(row, id: \.self) { item in
                Group {
                    if item >= self.itemCount {
                        if item == self.itemCount {
                            self.addButton(index: item - 1)
                        } else {
                            Text("This shouldn't happen!")
                        }
                    } else {
                        self.getItem(item)
                            .frame(width: self.itemWidth)
                            .onTapGesture(count: 1) {
                                self.deleteItem(item)
                            }
                    }
                }
            }.padding(.horizontal, self.spacing / 2)
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            ForEach(self.rows, id: \.self) { row in
                self.buildRow(row: row)
            }.padding(.horizontal, self.spacing / 2)
        }
    }
}

public struct GridView<Element>: View where Element: View {
    private let rows: [[Int]]
    private let getItem: (Int) -> Element
    private let addItem: (Int) -> Void
    private let deleteItem: (Int) -> Void
    private let itemCount: Int
    private let maxItemCount: Int
    private let spacing: CGFloat

    init(itemCount: Int, maxItemCount: Int, columnCount: Int,
         spacing: Int, getItem: @escaping (Int) -> Element,
         addItem: @escaping (Int) -> Void,
         deleteItem: @escaping (Int) -> Void) {
        self.maxItemCount = maxItemCount
        self.itemCount = itemCount
        self.getItem = getItem
        self.addItem = addItem
        self.deleteItem = deleteItem
        self.spacing = CGFloat(spacing)

        let items = Array(0 ..< min(itemCount + 1, maxItemCount))
        rows = items.chunked(into: columnCount)
    }

    public var body: some View {
        GeometryReader { geometry in
            InternalGridView(
                itemWidth: calculateColumnWidth(
                    totalWidth: geometry.size.width,
                    minimumItemWidth: 32,
                    columnCount: 2,
                    spacing: self.spacing
                ),
                spacing: self.spacing,
                getItem: self.getItem,
                addItem: self.addItem,
                deleteItem: self.deleteItem,
                rows: self.rows,
                itemCount: self.itemCount,
                maxItemCount: self.maxItemCount
            )
        }
    }
}

public struct BoothSelectionView: View {
    static let bundle = Bundle(identifier: "org.getyourgreenbacktompkins.UIFramework")
    @State var images: [Image] = []
    @State var otherImages: [Image] = [
        Image("ImageA", bundle: bundle),
        Image("ImageB", bundle: bundle),
        Image("ImageC", bundle: bundle),
        Image("ImageD", bundle: bundle),
    ]

    public init() {}

    public var body: some View {
        GridView(itemCount: images.count, maxItemCount: 4, columnCount: 2,
                 spacing: 20,
                 getItem: { (ind: Int) -> Image in
                     let image = self.images[ind]

                     return image.resizable(resizingMode: Image.ResizingMode.stretch)
                 },
                 addItem: { _ in
                     let image = self.otherImages.popLast()

                     if let image = image {
                         self.images.append(image)
                     }
                 },
                 deleteItem: { itemIndex in
                     let image = self.images.remove(at: itemIndex)

                     self.otherImages.append(image)
                 })
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
