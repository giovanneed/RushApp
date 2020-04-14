//
//  Product.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-12.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit
class Product {
    
    
    var image : UIImage?
    
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
    
    
    func imageBuffed(callback: @escaping(_ image: UIImage) -> Void){
        
        if let img = self.image {
            callback(img)
            return
        }
        
        if let URL = self.imageURL {
            downloadImage(from: URL) { (image) in
                if let img = image {
                    self.image = img
                    callback(img)
                } else {
                    callback(UIImage(named: "placeholder")!)

                }

            }
        }
    }
    
}


extension Product {
    
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
}




