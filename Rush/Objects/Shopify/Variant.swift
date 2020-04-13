//
//  Variant.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-13.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
class Variant {
    
    
    
   
    var variant_id: Int = 0
    var price = ""

    init(){
        
    }
    
    
    init(json: [String: AnyObject]) {
        print(json)
        if let variant_id = json["id"] as? Int {
            self.variant_id = variant_id
        }
        if let price = json["price"] as? String {
            self.price = price
        }
    }
    
   
}
