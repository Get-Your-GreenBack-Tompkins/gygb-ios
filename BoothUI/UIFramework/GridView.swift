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
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .padding()
            .foregroundColor(
                Color(red: 127 / 255.0, green: 127 / 255.0, blue: 127 / 255.0)
            )
            .background(
                Color(red: 244 / 255.0, green: 244 / 255.0, blue: 244 / 255.0)
            )
            .cornerRadius(50)
            .padding(.all, 30)
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
    private let maxItemCount: Int
    private let addItem: (Int) -> Void
    private let deleteItem: (Int) -> Void
    private let spacing: CGFloat
    @Binding private var items: [Element]

    init(items: Binding<[Element]>,
         itemWidth: CGFloat,
         spacing: CGFloat,
         addItem: @escaping (Int) -> Void,
         deleteItem: @escaping (Int) -> Void,
         rows: [[Int]],
         maxItemCount: Int) {
        _items = items
        self.itemWidth = itemWidth
        self.addItem = addItem
        self.spacing = spacing
        self.rows = rows
        self.maxItemCount = maxItemCount
        self.deleteItem = deleteItem
    }

    func addButton(index: Int) -> some View {
        Button(action: {
            self.addItem(index)
        }, label: {
            Image(systemName: "plus")
                .font(.largeTitle)
                .foregroundColor(
                    Color(
                        red: 127 / 255.0,
                        green: 127 / 255.0,
                        blue: 127 / 255.0
                    )
                )
        })
        .padding()
        .frame(width: itemWidth, height: itemWidth)
        .buttonStyle(BoothAddItemBackgroundStyle())
    }

    func buildRow(row: [Int]) -> some View {
        HStack {
            ForEach(row, id: \.self) { item in
                Group {
                    if item >= self.items.count {
                        if item == self.items.count {
                            self.addButton(index: item - 1)
                        } else {
                            Text("This shouldn't happen!")
                        }
                    } else {
                        self.items[item]
                            .frame(width: self.itemWidth, height: self.itemWidth)
                            .cornerRadius(40)
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
    private let addItem: (Int) -> Void
    private let deleteItem: (Int) -> Void
    private let maxItemCount: Int
    private let spacing: CGFloat
    @Binding private var items: [Element]

    public init(items: Binding<[Element]>, maxItemCount: Int, columnCount: Int,
         spacing: Int,
         addItem: @escaping (Int) -> Void,
         deleteItem: @escaping (Int) -> Void) {
        _items = items
        self.maxItemCount = maxItemCount
        self.addItem = addItem
        self.deleteItem = deleteItem
        self.spacing = CGFloat(spacing)

        let items = Array(0 ..< min(items.wrappedValue.count + 1, maxItemCount))
        rows = items.chunked(into: columnCount)
    }

    public var body: some View {
        GeometryReader { geometry in
            InternalGridView(
                items: self.$items,
                itemWidth: calculateColumnWidth(
                    totalWidth: geometry.size.width,
                    minimumItemWidth: 32,
                    columnCount: 2,
                    spacing: self.spacing
                ),
                spacing: self.spacing,
                addItem: self.addItem,
                deleteItem: self.deleteItem,
                rows: self.rows,
                maxItemCount: self.maxItemCount
            )
        }
    }
}
