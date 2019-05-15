//
//  QuickLookViewController.swift
//  QuickDock
//
//  Created by LTXX on 2019/4/23.
//  Copyright © 2019 LTXX. All rights reserved.
//

import UIKit

class QuickLookViewController: UIViewController {
    
    @IBOutlet weak var topLeftImageView: UIImageView!
    @IBOutlet weak var topRightImageView: UIImageView!
    @IBOutlet weak var bottomLeftImageView: UIImageView!
    @IBOutlet weak var bottomRightImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configImageView()
    }
    
    // 添加新图片
    @IBAction func addImage(_ sender: Any) {
    }
    
    // 用于从设置返回
    @IBAction func unwind(unwindSegue: UIStoryboardSegue) { }
    
    // 配置imageView的外观
    func configImageView() {
        
    }
}

// MARK: - 从相册 / 相机添加图片扩展
extension QuickLookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func addNewImage(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        let alertController = UIAlertController(title: "Choose", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        // 判断相册是否可读取
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "相册", style: .default, handler: {
                action in imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        
        // 判断相机是否可用
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction(title: "相机", style: .default, handler: {
                action in imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(cameraAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // ------- 测试 ---------
            topLeftImageView.image = selectedImage
            // ---------------------
            dismiss(animated: true, completion: nil)
        }
    }
}
