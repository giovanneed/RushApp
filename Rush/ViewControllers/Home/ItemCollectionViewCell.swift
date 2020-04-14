//
//  ItemCollectionViewCell.swift
//  Rush
//
//  Created by gio emiliano on 2020-02-18.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var itemBackgroundView: UIView!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    @IBOutlet weak var itemLabelName: UILabel!
    @IBOutlet weak var itemLabelPrice: UILabel!
    @IBOutlet weak var itemLabelCalories: UILabel!
    
    func setup(item: Item){
        itemBackgroundView.materialCardLayout()
        itemLabelName.text = item.name
        itemLabelPrice.text = item.formattedPrice()
        itemLabelCalories.text = item.formattedCal()
        mainImage.image = UIImage(named: item.mainImage)
    }
    
    func setup(product: Product){
        itemBackgroundView.materialCardLayout()
        itemLabelPrice.text = product.formattedPrice()

        itemLabelName.text = product.title
        
        if let img = product.image {
            self.mainImage.image = img
            self.mainImage.semiRounded()
            
            return
        }
        
        product.imageBuffed { (image) in
            DispatchQueue.main.async {
                self.mainImage.image = image
            }
        }
        
        self.mainImage.semiRounded()


        
    }
    
    
}
