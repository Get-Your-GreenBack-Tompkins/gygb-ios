//
//  ContentView.swift
//  BoothUI
//
//  Created by Evan Welsh on 4/18/20.
//  Copyright © 2020 Evan Welsh. All rights reserved.
//

import SwiftUI
import UIFramework

struct ContentView: View {
    var body: some View {
        BoothSelectionView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: Alignment.topLeading)
    }
}
