//
//  ShoppingCart.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-13.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
class ShoppingCart {
    
    private static var sharedShoppingCart: ShoppingCart = {
           let shared = ShoppingCart()
           return shared
       }()
    
    
    var products : [Product] = []

    var orderCompleted = false
    
    init(){
        
    }
    
    class func shared() -> ShoppingCart {
           return sharedShoppingCart
    }

    func reset(){
        orderCompleted = true
        products = []
    }
    
    func orderToJSON()->[String:Any]{
        
        var items = [Any]()
        
        for product in products {
            
            let item = [
                "variant_id": product.getID(),
              "quantity": 1
                ] as [String : Any]
            
            items.append(item)
            
        }
      
    let JSON = [
          "order": [
            "email": "postman@example.com",
            "customer": [
                    "email": "bob.norman@hostmail.com",
                    "first_name": Client.shared().firstName,
                    "last_name": Client.shared().lastName
            ],
            "line_items": items
          ]
        ]
        
        return JSON
        
    }
   
}
