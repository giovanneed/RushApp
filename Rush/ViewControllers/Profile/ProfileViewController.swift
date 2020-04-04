//
//  ProfileViewController.swift
//  Rush
//
//  Created by gio emiliano on 2020-03-02.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var profilePic: UIImageView!
    
    var imagePicker = UIImagePickerController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewProfile.materialCardLayout()
        profilePic.rounded()
        imagePicker.delegate = self

    

        // Do any additional setup after loading the view.
    }
    
    @IBAction func chooseNewPic(_ sender: Any) {
        pickImageFromGallery(imagePicker: self.imagePicker)

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension ProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
           picker.dismiss(animated: true, completion: nil)
           let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                    profilePic.image = image

    }
    
    func pickImageFromGallery(imagePicker: UIImagePickerController){
           
           if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){

                                       imagePicker.sourceType = .savedPhotosAlbum
                                       imagePicker.allowsEditing = false

                                       present(imagePicker, animated: true, completion: nil)
                            }
           
       }
       
       
      
       
}
