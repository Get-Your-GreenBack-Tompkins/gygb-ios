//
//  ViewController.swift
//  thermalcamera
//
//  Created by Ashneel Das on 1/27/20.
//  Copyright © 2020 Ashneel  Das. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FLIRDiscoveryEventDelegate, FLIRDataReceivedDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func cameraFound(_ cameraIdentity: FLIRIdentity) {

    }

    func onConnectionStatusChanged(_ camera: FLIRCamera, status: FLIRConnectionStatus, withError error: Error?) {

    }

    func cameraLost(_ cameraIdentity: FLIRIdentity) {
        // TODO: Handle camera loss.
    }

    func imageReceived() {

    }

    func discoveryFinished(_ iface: FLIRCommunicationInterface) {
        print("discoveryFinished!")
    }

    func discoveryError(_ error: String, netServiceError nsnetserviceserror: Int32, on iface: FLIRCommunicationInterface) {
        // TODO: Handle discover errors.
        print("discoveryError!")
    }
}
