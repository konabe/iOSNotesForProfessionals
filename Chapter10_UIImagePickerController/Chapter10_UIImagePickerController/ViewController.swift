//
//  ViewController.swift
//  UIImagePickerController
//
//  Created by 小鍋涼太 on 2021/08/27.
//

import UIKit

// Chapter 10: UIImagePickerController
// UIImagePickerControllerはデバイスから画像を選ばせたり、カメラで写真を撮ったりして提供することができるようにする独創的な方法である。
// UIImagePickerControllerDelegateに従うようにすると、画像をどのように提供するかについてのロジックを作成できる。（それをどうするか、キャンセルしたときどうするか）

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    // NOTE: UINavigationControllerを継承していて、UINavigationControllerDelegateプロトコルも入れないといけない。
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // §10.1 Generic usage of UIImagePickerController
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        button.addAction(.init { _ in
            self.present(self.imagePickerController, animated: true, completion: nil)
        }, for: .touchUpInside)
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            imageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
        imageView.image = nil
    }
}

extension ViewController: UINavigationControllerDelegate {
    
}
