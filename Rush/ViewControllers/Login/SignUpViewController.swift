//
//  SignUpViewController.swift
//  Rush
//
//  Created by gio emiliano on 2020-03-02.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var viewRegister: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        viewRegister.materialCardLayout()
        profilePic.rounded()
        
        // Do any additional setup after loading the view.
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
