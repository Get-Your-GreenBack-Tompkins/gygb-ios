//
//  ThermalCameraProvider.swift
//  UIFramework
//
//  Created by Evan Welsh on 4/19/20.
//  Copyright © 2020 Get Your GreenBack Tompkins. All rights reserved.
//

import SwiftUI

struct ThermalViewRepresentable: UIViewRepresentable {
    
    @Binding var isShown: Bool
    @Binding var image: Image?
    
    init(isShown: Binding<Bool>, image: Binding<Image?>) {
        _isShown = isShown
        _image = image
    }
    
    func updateUIView(_: ThermalCameraView, context _: Context) {
        print("updating...")
    }
    
    func setImage(i: Image) {
        image = i
    }
    
    func makeUIView(context _: Context) -> ThermalCameraView {
        let view = ThermalCameraView(frame: .zero)
        view.onCapture { i in
            self.setImage(i: i)
        }
        view.onSave {
            self.isShown = !self.isShown
        }
        return view
    }
}

class ThermalCameraView: UIView, FLIRDiscoveryEventDelegate, FLIRDataReceivedDelegate {
    
    var discoverer: FLIRDiscovery!
    var camera: FLIRCamera!
    var frameViewer: UIImageView!
    var container: UIView!
    var capture: UIButton!
    var updateImage: ((Image) -> Void)!
    var saveImage: (() -> Void)!
    
    func onCapture(callback: @escaping (Image) -> Void) {
        updateImage = callback
    }
    
    func onSave(callback: @escaping () -> Void) {
        saveImage = callback
    }
    
    @objc func touchUpCapture(sender: UIButton!) {
        print("HI")
        if let weakCamera = self.camera {
            // Run on the main thread (async)
            // Get the camera's image.
            if weakCamera.isGrabbing() {
                print("HI3")
                weakCamera.withImage { (image: FLIRThermalImage) in
                    let newImage = image.getImage();
                    print(newImage)
                    self.updateImage(Image(uiImage: newImage!))

                }
            }
        }
        self.camera.unsubscribeStream()
        self.saveImage()
    }
    
    func cameraFound(_ cameraIdentity: FLIRIdentity) {

        // Run in the main thread.
        DispatchQueue.main.async {
            // Connect our camera to the found identity.
            self.camera.connect(cameraIdentity)
            // Stop discovery.
            self.discoverer.stop()
        }
    }
    
    func discoveryError(_ error: String, netServiceError nsnetserviceserror: Int32, on iface: FLIRCommunicationInterface) {
    }
    
    func onConnectionStatusChanged(_ camera: FLIRCamera, status: FLIRConnectionStatus, withError error: Error?) {
        if status == FLIRConnectionStatus.connected {
            // Stream frames.
            camera.subscribeStream()
        }

        if status == FLIRConnectionStatus.disconnected {
            // Stop streaming frames.
            camera.unsubscribeStream()

            DispatchQueue.main.async { [weak self] in
                self?.frameViewer.image = nil
            }
        }
    }

    func imageReceived() {
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
                        
                        self.frameViewer?.image = image.getImage()
                        if let fusion = image.getFusion() {

                        }
                    }
                } else {
                    print("not grabbing...")
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true

        container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        frameViewer = UIImageView()
        frameViewer.translatesAutoresizingMaskIntoConstraints = false
        frameViewer.backgroundColor = .black

        capture = UIButton(type: .roundedRect)
        capture.translatesAutoresizingMaskIntoConstraints = false
        capture.setTitle("Take picture", for: .normal)
        capture.addTarget(self, action: #selector(touchUpCapture), for: .touchUpInside)
        container.addSubview(capture)
        container.addSubview(frameViewer)
        addSubview(container)
        constraints()
        
        camera = FLIRCamera()
        camera.delegate = self

        discoverer = FLIRDiscovery()
        discoverer.delegate = self
        discoverer.start(FLIRCommunicationInterface.emulator)
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            capture.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            capture.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 270),

            frameViewer.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            frameViewer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            frameViewer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            frameViewer.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.7),
            frameViewer.widthAnchor.constraint(equalTo: container.widthAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
