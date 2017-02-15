//
//  ViewController.swift
//  OpenCV Face Detection
//
//  Created by Marcos Castaneda on 2/15/17.
//  Copyright © 2017 Marcos Castaneda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    // Image Controller
    private lazy var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = OCVWrapper.versionNumber()

        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
    }

    @IBAction func captureDidTouch(_ sender: Any) {
        present(imagePicker, animated: true)
    }

    // Classify image function
    func classifyImage() {
        let image = OCVWrapper.classifyImage(imageView.image)

        if (image != nil) {
            imageView.image = image
            feedbackLabel.text = "Face found!"
            feedbackLabel.textColor = UIColor(red: 0, green: 180/255, blue: 0, alpha: 1)
        } else {
            feedbackLabel.text = "Nothing found"
            feedbackLabel.textColor = UIColor.red
        }
    }
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage

        classifyImage()

        dismiss(animated: true, completion: nil)
    }
}

