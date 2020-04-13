//
//  TabBarViewController.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-13.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if ShoppingCart.shared().orderCompleted == true {
            ShoppingCart.shared().orderCompleted = false
            self.selectedIndex = 1
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueCart" {
            
            if ShoppingCart.shared().products.count == 0 {
                let alert = UIAlertController(title: "Sorry", message: "Your shopping cart is empty.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    
                    
                }))
                self.present(alert, animated: true)
                
            } 
            
            
        }
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
