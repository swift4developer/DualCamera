//
//  DualCameraManager.swift
//  DualCamera
//
//  Created by Ashwinee Dhakde on 26/12/25.
//

import AVFoundation
import UIKit

final class DualCameraManager {

    let session = AVCaptureMultiCamSession()

    let backPreviewLayer = AVCaptureVideoPreviewLayer()
    let frontPreviewLayer = AVCaptureVideoPreviewLayer()

    func configure() {
        guard AVCaptureMultiCamSession.isMultiCamSupported else {
            print("❌ MultiCam not supported")
            return
        }

        session.beginConfiguration()

        // MARK: - BACK CAMERA
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back),
            let backInput = try? AVCaptureDeviceInput(device: backCamera) else { return }

        let backOutput = AVCaptureVideoDataOutput()

        session.addInputWithNoConnections(backInput)
        session.addOutputWithNoConnections(backOutput)

        let backInputPort = backInput.ports.first!
        let backOutputConnection = AVCaptureConnection(inputPorts: [backInputPort], output: backOutput)

        if session.canAddConnection(backOutputConnection) {
            session.addConnection(backOutputConnection)
        }

        let backPreviewConnection = AVCaptureConnection(inputPort: backInputPort, videoPreviewLayer: backPreviewLayer)

        if session.canAddConnection(backPreviewConnection) {
            session.addConnection(backPreviewConnection)
        }

        backPreviewLayer.videoGravity = .resizeAspectFill
        backPreviewLayer.session = session

        // MARK: - FRONT CAMERA
        guard let frontCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front),
            let frontInput = try? AVCaptureDeviceInput(device: frontCamera)  else { return }

        let frontOutput = AVCaptureVideoDataOutput()

        session.addInputWithNoConnections(frontInput)
        session.addOutputWithNoConnections(frontOutput)

        let frontInputPort = frontInput.ports.first!
        let frontOutputConnection = AVCaptureConnection(inputPorts: [frontInputPort],
                                                         output: frontOutput)

        if session.canAddConnection(frontOutputConnection) {
            session.addConnection(frontOutputConnection)
        }

        let frontPreviewConnection = AVCaptureConnection(inputPort: frontInputPort,
                                                          videoPreviewLayer: frontPreviewLayer)

        if session.canAddConnection(frontPreviewConnection) {
            session.addConnection(frontPreviewConnection)
        }

        frontPreviewLayer.videoGravity = .resizeAspectFill
        frontPreviewLayer.session = session

        session.commitConfiguration()
        session.startRunning()
    }
}
