//
//  Product.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-12.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
class Product {
    
    
    
    var title = ""
    var desc = ""

    var variant_id = 0
    var imageURL : URL?

    var variants : [Variant] = []
    
    init(){
        
    }
    
    func getID()->Int {
        return variants[0].variant_id
    }
    
    func formattedPrice()->String{
        return "CAD " + variants[0].price
    }
    
    func price()->Double{
        return Double(variants[0].price) as! Double
    }
    
    init(json: [String: AnyObject]) {
        if let title = json["title"] as? String {
            self.title = title
        }
        
        if let desc = json["body_html"] as? String {
            self.desc = desc
        }
        
        
        
        if let image = json["image"]  {
            if let src = image["src"] as? String {
                if let imgURL =  URL(string: src)  {
                    self.imageURL = imgURL

                }

            }
        }
        
        if let modelVariants = json["variants"] as? [AnyObject] {
             
            for modelVariantDatabase in modelVariants {
                if let modelVariant = modelVariantDatabase as? [String:AnyObject] {
                    let variant = Variant(json: modelVariant)
                    variants.append(variant)
                }
            }
        }
    }
    
   
}
