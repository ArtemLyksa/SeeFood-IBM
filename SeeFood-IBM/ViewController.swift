//
//  ViewController.swift
//  SeeFood-IBM
//
//  Created by Artem Lyksa on 9/12/19.
//  Copyright © 2019 lyksa. All rights reserved.
//

import UIKit
import VisualRecognitionV3

class ViewController: UIViewController {

    @IBOutlet weak var resultImageView: UIImageView!
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    
    let imagePickerController = UIImagePickerController()
    let visualRecognition = VisualRecognition(version: "2019-09-13", apiKey: "IcCmaYnegnt0xgsuFyOZWqLPvP5jqAiZ6FJ9KYaVLGA2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
    }

    @IBAction func cameraBarButtonAction(_ sender: UIBarButtonItem) {
        imagePickerController.sourceType = .savedPhotosAlbum
        imagePickerController.allowsEditing = false
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func recognize(image: UIImage) {
        let imageData = image.jpegData(compressionQuality: 0.01)
        visualRecognition.classify(imagesFile: imageData) { classifiedImages, error in
            print(classifiedImages?.result)
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
