//
//  CaptureQRCodeViewController.swift
//  APITest
//
//  Created by SuJustin on 2019/9/3.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import AVFoundation
import UIKit

class CaptureQRCodeViewController: UIViewController {
    
    var activity: UIActivityIndicatorView!
    var session: AVCaptureSession!
    var qrCodeLayer: AVCaptureVideoPreviewLayer!
    var qrCodeFrame: UIView!
    var sessionCanRunning = false

    @IBOutlet weak var QRCodeView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        activity = UIActivityIndicatorView(style: .whiteLarge)
        activity.center = view.center
        view.addSubview(activity)
        
        authCameraAccess()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func fromAlbumAction(_ sender: UIButton) {
        
    }
    
    fileprivate func running() {
        activity.stopAnimating()
        self.session.startRunning()
    }
    
    private func CaptureSessionSetup() {
        activity.startAnimating()
        session = AVCaptureSession()
        guard SessionInputSetup() else{
            activity.stopAnimating()
            return
        }
        guard SessionOutputSetup() else {
            activity.stopAnimating()
            return
        }
        QRCodeLayerSetup()
        QRCodeFrameSetup()
        sessionCanRunning = true
        running()
    }
    private func SessionInputSetup() -> Bool{
        guard let videoDevice = AVCaptureDevice.default(for: .video) else {
            print("[Session Input Error] videoDevice initial is error.")
            return false
        }
        let videoInput: AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoDevice)
        } catch  {
            print("[Capture Error]: \(error)")
            return false
        }
        
        guard session.canAddInput(videoInput) else {
            showErrorAlert()
            return false
        }
        session.addInput(videoInput)
        return true
    }
    private func SessionOutputSetup() -> Bool{
        let metadataOutput = AVCaptureMetadataOutput()
        guard session.canAddOutput(metadataOutput) else {
            showErrorAlert()
            return false
        }
        session.addOutput(metadataOutput)
        
        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        metadataOutput.metadataObjectTypes = [.qr]
        return true
    }
    private func QRCodeLayerSetup(){
        qrCodeLayer = AVCaptureVideoPreviewLayer(session: session)
        qrCodeLayer.frame = view.layer.bounds
        qrCodeLayer.videoGravity = .resizeAspectFill
        QRCodeView.layer.addSublayer(qrCodeLayer)
    }
    private func QRCodeFrameSetup(){
        qrCodeFrame = UIView()
        qrCodeFrame.layer.borderColor = UIColor.white.cgColor
        qrCodeFrame.layer.borderWidth = 5
        qrCodeFrame.layer.masksToBounds = true
        qrCodeFrame.layer.cornerRadius = 10
        // Add to superview
//        view.layer.addSublayer(qrCodeFrame)
//        view.insertSublayer(qrCodeFrame, above: qrCodeLayer)
        QRCodeView.addSubview(qrCodeFrame)
        QRCodeView.bringSubviewToFront(qrCodeFrame)
    }
    
    fileprivate func showErrorAlert() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        session = nil
    }
}
extension CaptureQRCodeViewController: AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        session.stopRunning()
        activity.startAnimating()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            
            // Get QRData
            let decoder = JSONDecoder()
            do{
                let qrCodeValue = try decoder.decode(QRCodeValue.self, from: stringValue.data(using: .utf8)!)
                let alertstring = """
                Name: \(qrCodeValue.name ?? "")
                Years: \(qrCodeValue.years ?? "")
                Email: \(qrCodeValue.email ?? "")
                """
                let alert = UIAlertController(title: "QRCode Data", message: alertstring, preferredStyle: .alert)
                let action = UIAlertAction(title: "Enter", style: .default){ action in
                    self.running()
                }
                alert.addAction(action)
                present(alert, animated: true)
            }catch{
                print(error)
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
extension CaptureQRCodeViewController{
    private func authCameraAccess() {
        let status: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        guard status == AVAuthorizationStatus.authorized else{
            AVCaptureDevice.requestAccess(for: .video) { [weak self] (agree: Bool) in
                if agree{
                    self!.CaptureSessionSetup()
                }else{
                    self!.settingAuthFromAlert()
                }
            }
            return
        }
        self.CaptureSessionSetup()
    }
    private func settingAuthFromAlert() {
        let alert = UIAlertController(title: "相機存取", message: "請允許相機存取", preferredStyle: .alert)
        let action = UIAlertAction(title: "確認", style: .cancel)
        let setting = UIAlertAction(title: "設定", style: .default) { (action) in
            guard let settingUrl = URL(string: UIApplication.openSettingsURLString)else{
                return
            }
            if UIApplication.shared.canOpenURL(settingUrl){
                UIApplication.shared.open(settingUrl){ (success) in
                    print("[SUCCESS] Settings opened: \(success)")
                }
            }
        }
        alert.addAction(setting)
        alert.addAction(action)
        present(alert, animated: true)
        print("[ERROR-Auth] Camera!!\(#line)")
    }
}
