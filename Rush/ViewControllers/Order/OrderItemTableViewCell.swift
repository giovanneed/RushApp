//
//  OrderItemTableViewCell.swift
//  Rush
//
//  Created by gio emiliano on 2020-03-31.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

protocol OrderItemeCellDelegate: class {
  
    func removeItem(_ item: Item, indexPath: IndexPath)
}


class OrderItemTableViewCell: UITableViewCell {
    
    
    var delegate : OrderItemeCellDelegate?

    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemDetail: UILabel!
    @IBOutlet weak var itemExtras: UILabel!
    
    @IBOutlet weak var itemTitle: UILabel!
    var item = Item()
    var product = Product()

    var indexPath = IndexPath()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setup(item: Item, indexPath: IndexPath){
        
        viewBackground.materialCardLayout()
        self.item = item
        self.indexPath = indexPath
        
        itemTitle.text = item.formattedTitle()
        itemPrice.text = item.formattedPrice()
        itemDetail.text = item.formattedCal()
        itemImage.image = UIImage(named: item.mainImage)
        itemExtras.text = item.formattedExtras()

     
    }
    
    
    public func setup(product: Product, indexPath: IndexPath){
        
        viewBackground.materialCardLayout()
        
        self.product = product
        self.indexPath = indexPath
        
        itemTitle.text = product.title
        if let URL = product.imageURL {
            itemImage.downloadImage(from: URL)
            
        }
        itemPrice.text = product.formattedPrice()

        
    }

    @IBAction func removeItem(_ sender: Any) {
        
        delegate?.removeItem(item, indexPath: indexPath)
        
        
    }
}
