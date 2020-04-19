//
//  CameraView.swift
//  thermalcamera
//
//  Created by Ashneel  Das on 4/18/20.
//  Copyright © 2020 Ashneel  Das. All rights reserved.
//

class CameraViewController: UIViewController, FLIRDiscoveryEventDelegate, FLIRDataReceivedDelegate {

    var imageDelegate: imageDelegate!
    var discoverer: FLIRDiscovery!
    var camera: FLIRCamera!

    var frameViewer: UIImageView!
    var startButtonView: UIView!
    var stopButtonView: UIView!
    var container: UIView!

    var emulatorButton: UIButton!
    var lightningButton: UIButton!
    var stopButton: UIButton!

    var rotateButton: UIButton!

    var rotation: Double = 0.0

    @objc func touchUpEmulator(sender: UIButton!) {
        // This will start "searching" for the emulated FLIR device.
        // This should never fail as the emulator is always available!
        print("touch up - emulator")
        discoverer.start(FLIRCommunicationInterface.emulator)

        self.setButtonView(type: .stop)
    }

    @objc func touchUpLightning(sender: UIButton!) {
        print("touch up - lightning")
        // This will start searching for FLIR devices via the Lightning connector (most wired connections)
        discoverer.start(FLIRCommunicationInterface.lightning)

        self.setButtonView(type: .stop)
    }

    @objc func touchUpStop(sender: UIButton!) {
        print("touch up - stop")

        if discoverer.isDiscovering() {
            discoverer.stop()
        } else {
            // Disconnect.
            camera.disconnect()
        }

        self.setButtonView(type: .start)
    }

    @objc func touchUpRotate(sender: UIButton!) {
        print("touch up - rotate")

        if rotation >= 2 * Double.pi {
            rotation = Double.pi / 2
        } else {
            rotation += Double.pi / 2
        }

        frameViewer?.transform = CGAffineTransform(rotationAngle: CGFloat(rotation))
    }

    func constraints() {
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            rotateButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: CGFloat(20.0)),
            rotateButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: CGFloat(20.0)),

            frameViewer.topAnchor.constraint(equalTo: container.topAnchor, constant: 0),
            frameViewer.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0),
            frameViewer.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0),
            frameViewer.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.7),
            frameViewer.widthAnchor.constraint(equalTo: container.widthAnchor),
        ])
    }

    func startConstraints() {
        NSLayoutConstraint.activate([
            startButtonView.topAnchor.constraint(greaterThanOrEqualTo: frameViewer.bottomAnchor, constant: 20),
            startButtonView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2),
            startButtonView.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 0),
            startButtonView.widthAnchor.constraint(equalTo: container.readableContentGuide.widthAnchor),
            startButtonView.bottomAnchor.constraint(greaterThanOrEqualTo: rotateButton.topAnchor),

            rotateButton.topAnchor.constraint(equalTo: startButtonView.bottomAnchor),

            emulatorButton.leadingAnchor.constraint(equalTo: startButtonView.leadingAnchor, constant: 20),
            emulatorButton.trailingAnchor.constraint(equalTo: startButtonView.centerXAnchor, constant: -20),
            emulatorButton.centerYAnchor.constraint(equalTo: startButtonView.centerYAnchor),

            lightningButton.leadingAnchor.constraint(equalTo: startButtonView.centerXAnchor, constant: 20),
            lightningButton.trailingAnchor.constraint(equalTo: startButtonView.trailingAnchor, constant: -20),
            lightningButton.centerYAnchor.constraint(equalTo: startButtonView.centerYAnchor),
        ])
    }

    func stopConstraints() {
        NSLayoutConstraint.activate([
            stopButtonView.topAnchor.constraint(greaterThanOrEqualTo: frameViewer.bottomAnchor, constant: 20),
            stopButtonView.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.2),
            stopButtonView.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: 0),
            stopButtonView.widthAnchor.constraint(equalTo: container.readableContentGuide.widthAnchor),
            stopButtonView.bottomAnchor.constraint(greaterThanOrEqualTo: rotateButton.topAnchor),

            rotateButton.topAnchor.constraint(equalTo: stopButtonView.bottomAnchor),

            stopButton.centerXAnchor.constraint(equalTo: stopButtonView.centerXAnchor),
            stopButton.centerYAnchor.constraint(equalTo: stopButtonView.centerYAnchor),
        ])
    }

    enum ButtonViewType {
        case stop
        case start
    }

    func setButtonView(type: ButtonViewType) {
        switch type {
        case .stop:
            startButtonView.removeFromSuperview()
            container.addSubview(stopButtonView)
            stopConstraints()
            view.updateConstraints()
        case .start:
            stopButtonView.removeFromSuperview()
            container.addSubview(startButtonView)
            startConstraints()
            view.updateConstraints()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.clipsToBounds = true

        container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        startButtonView = UIView()
        startButtonView.translatesAutoresizingMaskIntoConstraints = false

        emulatorButton = UIButton(type: .roundedRect)
        emulatorButton.setTitle("Emulator", for: .normal)
        emulatorButton.translatesAutoresizingMaskIntoConstraints = false
        emulatorButton.addTarget(self,
                action: #selector(touchUpEmulator),
                for: .touchUpInside)

        startButtonView.addSubview(emulatorButton)

        lightningButton = UIButton(type: .roundedRect)
        lightningButton.setTitle("Lightning", for: .normal)
        lightningButton.translatesAutoresizingMaskIntoConstraints = false
        lightningButton.addTarget(self,
                action: #selector(touchUpLightning),
                for: .touchUpInside)

        startButtonView.addSubview(lightningButton)

        stopButtonView = UIView()
        stopButtonView.translatesAutoresizingMaskIntoConstraints = false

        stopButton = UIButton(type: .roundedRect)
        stopButton.setTitle("Stop Stream", for: .normal)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        stopButton.addTarget(self,
                action: #selector(touchUpStop),
                for: .touchUpInside)
        stopButtonView.addSubview(stopButton)

        rotateButton = UIButton(type: .roundedRect)
        rotateButton.setTitle("Rotate", for: .normal)
        rotateButton.translatesAutoresizingMaskIntoConstraints = false
        rotateButton.addTarget(self,
                action: #selector(touchUpRotate),
                for: .touchUpInside)
        rotateButton.backgroundColor = .magenta
        container.addSubview(rotateButton)

        frameViewer = UIImageView()
        frameViewer.translatesAutoresizingMaskIntoConstraints = false
        frameViewer.backgroundColor = .black

        container.addSubview(frameViewer)
        view.addSubview(container)

        setButtonView(type: .start)

        constraints()

        // Create a FLIR Camera
        camera = FLIRCamera()
        camera.delegate = self

        // Create a a FLIR Discovery Interface
        discoverer = FLIRDiscovery()
        discoverer.delegate = self
    }

    func cameraFound(_ cameraIdentity: FLIRIdentity) {
        print("cameraFound!")

        // Run in the main thread.
        DispatchQueue.main.async {
            // Connect our camera to the found identity.
            self.camera.connect(cameraIdentity)
            // Stop discovery.
            self.discoverer.stop()
        }
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

    func cameraLost(_ cameraIdentity: FLIRIdentity) {
        // TODO: Handle camera loss.
        print("cameraLost!")
    }

    func imageReceived() {
        // Streamed frames are handled here.
        print("imageReceived!")

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

                        print("setting image!")
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

    func discoveryFinished(_ iface: FLIRCommunicationInterface) {
        print("discoveryFinished!")
    }

    func discoveryError(_ error: String, netServiceError nsnetserviceserror: Int32, on iface: FLIRCommunicationInterface) {
        // TODO: Handle discover errors.
        print("discoveryError!")
    }
}
