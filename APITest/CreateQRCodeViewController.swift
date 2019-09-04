//
//  ReadQRCodeViewController.swift
//  APITest
//
//  Created by SuJustin on 2019/9/3.
//  Copyright © 2019 SuJustin. All rights reserved.
//

import UIKit

struct QRCodeValue: Codable {
    let name, years, email: String?
}

class CreateQRCodeViewController: UIViewController {

    @IBOutlet weak var Fid_name: UITextField!
    @IBOutlet weak var Fid_year: UITextField!
    @IBOutlet weak var Fid_email: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var Btn_download: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        Fid_name.placeholder = "Your Name"
        Fid_year.placeholder = "Your Years"
        Fid_email.placeholder = "Yout Email"
        Fid_email.keyboardType = .emailAddress
        
        Btn_download.isEnabled = false
    }
    
    @IBAction func createQRCodeAction(_ sender: UIButton) {
        let qrCodeValue = QRCodeValue(name: Fid_name.text, years: Fid_year.text, email: Fid_email.text)
        let encoder = JSONEncoder()
        do{
            let qrCodeData = try encoder.encode(qrCodeValue)
            let image = generateQRCode(from: String(data: qrCodeData, encoding: .utf8)!)
            imageView.image = image
            self.Btn_download.isEnabled = true
        }catch{
            print(error)
        }
    }
    
    @IBAction func downloadAction(_ sender: UIButton) {
        guard let image = imageView.image else{
            print("ImageView's image is nil")
            return
        }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    @objc func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    private func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }
}
