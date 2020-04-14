//
//  ViewController+Extenions.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-13.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    func loading(show: Bool){
        if show {
           // let loading = UIActivityIndicatorView()
           // loading.startAnimating()
            let loading = UIImageView(image: UIImage(named: "loading"))
            loading.frame = CGRect(x: self.view.frame.width/2-40, y: self.view.frame.height/2-80, width: 80, height: 80)
            loading.rotate()
            
            let view = UIView(frame: self.view.frame)
                   view.backgroundColor = .black
                   view.alpha = 0.4
                   view.tag = 182
                   view.addSubview(loading)
                   
                   self.view.addSubview(view)
        }else {
            for view in view.subviews {
                if view.tag == 182 {
                    view.removeFromSuperview()
                }
            }
        }
       
    }
    
    func showMessage(title: String, message: String) {
           
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

           self.present(alert, animated: true) {
               
           }
       }
    
    func getTimestamp()->String{
         let timestamp = Int64(Date().timeIntervalSince1970 * 1000)

         return String(timestamp)

     }
    
    func pickImageFromGallery(imagePicker: UIImagePickerController){
        
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    
   
    
    
    
    func downloadImage(from url: URL, imageView: UIImageView) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                imageView.image = UIImage(data: data)
            }
        }
    }
    
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
           URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
       
    
    
    
}


extension UIImageView {
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getDataImage(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
    
    
    func getDataImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
     }
        
}


extension UIView {
    
    func downloadImage(from url: URL, callback: @escaping(_ image: UIImage?) -> Void) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
              callback( UIImage(data: data))
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
           URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
    func animate(callback: @escaping(_ finish: Bool?) -> Void) {
        
        UIView.animate(withDuration: 1, animations: {
            self.alpha = 0
        }) { _ in
            UIView.animate(withDuration: 1) {
                callback(true)
                self.alpha = 1
            }
            
        }
        
    }
    
    func rotate() {
           let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: M_PI * 2)
           rotation.duration = 1
        rotation.isCumulative = true
           rotation.repeatCount = FLT_MAX
        self.layer.add(rotation, forKey: "rotationAnimation")
       }
    
    
    
}
