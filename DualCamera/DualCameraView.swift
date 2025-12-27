//
//  DualCameraView.swift
//  DualCamera
//
//  Created by Ashwinee Dhakde on 27/12/25.
//

import UIKit

final class DualCameraView: UIView {

    private let manager = DualCameraManager()

    private let pipView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        manager.configure()

        setupBackCamera()
        setupPiPCamera()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupBackCamera() {
        manager.backPreviewLayer.frame = bounds
        layer.addSublayer(manager.backPreviewLayer)
    }

    private func setupPiPCamera() {
        pipView.backgroundColor = .black
        pipView.layer.cornerRadius = 12
        pipView.layer.masksToBounds = true

        addSubview(pipView)

        pipView.layer.addSublayer(manager.frontPreviewLayer)
        bringSubviewToFront(pipView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Back camera full screen
        manager.backPreviewLayer.frame = bounds

        // PiP frame (TOP-RIGHT)
        let pipWidth: CGFloat = 140
        let pipHeight: CGFloat = 200

        pipView.frame = CGRect(
            x: bounds.width - pipWidth - 16,
            y: 60,
            width: pipWidth,
            height: pipHeight
        )

        manager.frontPreviewLayer.frame = pipView.bounds
    }
}



