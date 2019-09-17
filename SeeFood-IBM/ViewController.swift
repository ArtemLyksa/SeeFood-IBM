//
//  ViewController.swift
//  SeeFood-IBM
//
//  Created by Artem Lyksa on 9/12/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import SVProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    @IBOutlet weak var topBarImageView: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
    }

    @IBAction func cameraBarButtonAction(_ sender: UIBarButtonItem) {
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func shareButtonAction(_ sender: UIButton) {
        
    }
    
    private func recognize(image: UIImage) {
        SVProgressHUD.show()
        cameraBarButton.isEnabled = false
        let imageData = image.jpegData(compressionQuality: 0.01)
        let visualRecognition = VisualRecognition(version: "2019-09-13", apiKey: "IcCmaYnegnt0xgsuFyOZWqLPvP5jqAiZ6FJ9KYaVLGA2")
        visualRecognition.classify(imagesFile: imageData) { classifiedImages, error in
            let classes = classifiedImages?.result?.images.first?.classifiers.first?.classes ?? []
            let names = classes.map({ $0.className })
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.cameraBarButton.isEnabled = true
                
                if names.contains("hotdog") {
                    self.navigationItem.title = "Hotdog!"
                    self.navigationController?.navigationBar.barTintColor = .green
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.topBarImageView.image = UIImage(named: "hotdog")
                } else {
                    self.navigationItem.title = "Not a hotdog"
                    self.navigationController?.navigationBar.barTintColor = .red
                    self.navigationController?.navigationBar.isTranslucent = false
                    self.topBarImageView.image = UIImage(named: "not-hotdog")
                }
            }
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let resultImage = info[.originalImage] as? UIImage {
            resultImageView.image = resultImage
            recognize(image: resultImage)
        } else {
            print("There was an error whle picking image")
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension ViewController: UINavigationControllerDelegate {
    
}
