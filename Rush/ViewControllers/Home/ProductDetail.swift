//
//  ProductDetail.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-13.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit

class ProductViewController: UIViewController {
    
    var product = Product()
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var titleFull: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var buttonAdd: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProductInfo()
    }
    
    func loadProductInfo(){
        self.titleFull.text = product.title
        
        product.imageBuffed { (image) in
            DispatchQueue.main.async {
                self.image.image = image
            }
        }
        
        image.semiRounded()
        image.contentMode = .scaleAspectFill
        
        
                
        price.text = product.formattedPrice()
        desc.text = product.desc
        
    }
    
    @IBAction func addToCart(_ sender: Any) {
        
        ShoppingCart.shared().products.append(product)
        dismiss(animated: true, completion: nil)

    }
    
}
