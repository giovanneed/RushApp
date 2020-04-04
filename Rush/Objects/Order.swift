//
//  Order.swift
//  Rush
//
//  Created by gio emiliano on 2020-03-02.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation


class Order {
    var items : [Item] = []
    var price : String = ""
    var status : OrderStatus = .created
}


enum OrderStatus {
    case created
    case making
    case onTheWay
    case done
    case canceled
}


class CurrentOrder {
    
    var order : Order = Order()

    // MARK: - Properties

    private static var sharedCurrentOrderr: CurrentOrder = {
        let sharedCurrentOrderr = CurrentOrder()

        // Configuration
        // ...

        return sharedCurrentOrderr
    }()

    // MARK: -

   // let baseURL: URL

    // Initialization

    private init() {
       // self.baseURL = baseURL
    }

    // MARK: - Accessors

    class func shared() -> CurrentOrder {
        return sharedCurrentOrderr
    }
    
   
    func total()->String{
        
        var total = 0.0
        for item in order.items {
            total = total + item.fullPrice()
        }
        
        return "CAD \(total)"
    }
    
    func removeItem(_ item:Item) {
        
        for (index, element) in order.items.enumerated() {
            if item === element {
                order.items.remove(at: index)
                return
            }
        }
       
    }

}
