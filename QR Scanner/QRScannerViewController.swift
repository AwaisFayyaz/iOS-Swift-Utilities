//
//  QRCodeReader.swift
//  AccessAgriculture
//
//  Created by BugDev Studios on 02/08/2019.
//  Copyright © 2019 bugdev. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

class QRScannerViewController: ParentViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    weak var delegate: QRCodeReaderVCDelegate?
    
    @IBOutlet weak var viewScannerFull: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            let message = "Capture Device Not Found"
            AAPrint(message)
            showToast(Message: message)
            return
            
        }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = viewScannerFull.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        viewScannerFull.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    func failed() {
        let title = "Scanning not supported".localizedString
        let message = "Your device does not support scanning a code from an item. Please use a device with a camera.".localizedString
        let ac = UIAlertController(title: title , message: message , preferredStyle: .alert)
        
        ac.addAction(UIAlertAction.init(title: "OK".localizedString, style: .default, handler: { (action) in
//            self.dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
            self.navigationController?.popViewController(animated: true)
        }
        
//        dismiss(animated: true)
    }
    
    func found(code: String) {
        AAPrint("Cool. Scanned QR string, the code is \(code)")
        delegate?.found(code: code)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

protocol QRCodeReaderVCDelegate: class {
    func found(code: String)
}
