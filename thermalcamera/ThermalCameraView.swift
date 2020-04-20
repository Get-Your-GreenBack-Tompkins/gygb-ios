//
//  ThermalCameraProvider.swift
//  UIFramework
//
//  Created by Evan Welsh on 4/19/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI
import UIFramework

struct ThermalViewRepresentable: UIViewRepresentable {

    @Binding var isShown: Bool
    @Binding var image: UIImage?

    init(isShown: Binding<Bool>, image: Binding<UIImage?>) {
        _isShown = isShown
        _image = image
    }

    public func makeCoordinator() -> ThermalCameraCoordinator {
        return ThermalCameraCoordinator(image: $image)
    }

    func makeUIView(context: Context) -> UIImageView {
        let frameViewer = UIImageView()

        frameViewer.translatesAutoresizingMaskIntoConstraints = false
        frameViewer.backgroundColor = .black

        return frameViewer
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        print("updating image viewer...")
        if isShown {
            print("setting image...")
            uiView.image = image
            uiView.setNeedsDisplay()
        }
    }
}

public class ThermalCameraCoordinator: NSObject, FLIRDiscoveryEventDelegate, FLIRDataReceivedDelegate {
    @Binding var image: UIImage?

    public init(image: Binding<UIImage?>) {
        _image = image

        super.init()

        camera = FLIRCamera()
        camera.delegate = self

        discoverer = FLIRDiscovery()
        discoverer.delegate = self
        discoverer.start(FLIRCommunicationInterface.emulator)
    }

    var discoverer: FLIRDiscovery!
    var camera: FLIRCamera!

    public func cameraFound(_ cameraIdentity: FLIRIdentity) {
        // Run in the main thread.
        DispatchQueue.main.async {
            // Connect our camera to the found identity.
            self.camera.connect(cameraIdentity)
            // Stop discovery.
            self.discoverer.stop()
        }
    }

    public func discoveryError(_ error: String, netServiceError nsnetserviceserror: Int32, on iface: FLIRCommunicationInterface) {
    }

    public func onConnectionStatusChanged(_ camera: FLIRCamera, status: FLIRConnectionStatus, withError error: Error?) {
        if status == FLIRConnectionStatus.connected {
            // Stream frames.
            camera.subscribeStream()
        }

        if status == FLIRConnectionStatus.disconnected {
            // Stop streaming frames.
            camera.unsubscribeStream()
        }
    }

    public func imageReceived() {
        // Streamed frames are handled here.

        // Reference the camera.
        if let weakCamera = self.camera {
            // Run on the main thread (async)
            DispatchQueue.main.async { [weakCamera] in
                // Get the camera's image.
                if weakCamera.isGrabbing() {
                    weakCamera.withImage { (image: FLIRThermalImage) in
                        if let fusion = image.getFusion() {
                            fusion.setFusionMode(FUSION_MSX_MODE);
                            fusion.setVisualOnly(Color)
                        }

                        // Display the image in the UI.
                        image.setTemperatureUnit(TemperatureUnit.FAHRENHEIT)
//                        image.setColorDistribution(TemperatureLinear)
                        image.palette = image.paletteManager.rainbow
                        
                        self.image = image.getImage()
                        if let fusion = image.getFusion() {

                        }
                    }
                } else {
                    print("not grabbing...")
                }
            }
        }
    }
}

struct ThermalCameraView : View {
    @Binding var isShown: Bool
    @Binding var image: Image?
    @State var uiImage: UIImage?

    init(isShown: Binding<Bool>, image: Binding<Image?>) {
        _isShown = isShown
        _image = image
    }

    var body: some View {
        let imageBinding = Binding<UIImage?>(get: {
            return self.uiImage
        }, set: { uiImage in
            self.uiImage = uiImage

            if self.isShown {
                if let uiImage = uiImage {
                    self.image = Image(uiImage: uiImage)
                } else {
                    self.image = nil
                }
            }
        })

        return ZStack {
            CameraInterface(capture: {
                self.isShown = false
            },
            back: {
                self.image = nil
                self.isShown = false
            }) {
                if self.isShown {
                    ThermalViewRepresentable(
                        isShown: self.$isShown,
                        image: imageBinding
                    )
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                } else {
                    Text("No Source Detected.")
                }
            }
        }
    }
}
