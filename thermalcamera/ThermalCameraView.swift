//
//  ThermalCameraProvider.swift
//  UIFramework
//
//  Created by Evan Welsh on 4/19/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI

// TODO: Implement
struct ThermalCameraView: View {
    @State var isShown: Bool = false
    @State var image: Image?

    var body: some View {
        Text("Thermal Camera.")
    }
}

struct ThermalCameraView_Previews: PreviewProvider {
    static var previews: some View {
        ThermalCameraView()
    }
}
