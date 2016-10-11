//
//  ViewController.swift
//  HelloRecordVideo
//
//  Created by 洪德晟 on 2016/10/7.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit

// 4-1. 匯入函式庫MobileCoreServices & Photos
import MobileCoreServices

import Photos

// 6. 服從UIImagePickerControllerDelegate, UINavigationControllerDelegate(知道錄影完要做啥)
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // 1. 產生 Record 按鈕
    @IBAction func recordVideo(_ sender: UIButton) {
        
        // 2. 錄影
        // 2. 測試目前機型是否有錄影 camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // 3. 產生UIImagePickerController
            let imagePicker = UIImagePickerController()
            
            // 4. 設定sourceType & mediaType
            imagePicker.sourceType = .camera
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            
            // 6-1. 知道錄影完要做啥，需服從UINavigationControllerDelegate才能當代理
            imagePicker.delegate = self
            
            // 5. 顯示UIImagePickerController
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // 7. 錄影完要做的事
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // 8. 用info參數拿到錄影短片的 url
        if let urlOfVideo = info[UIImagePickerControllerMediaURL] as? URL {
            PHPhotoLibrary.shared().performChanges({
                
                // 9. 存到相機膠卷
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: urlOfVideo)
                }, completionHandler: nil)
        }
        
        // 10. 讓 image picker controller 掉下來
        dismiss(animated: true, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }


}

