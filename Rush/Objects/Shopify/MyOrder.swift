//
//  MyOrder.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-13.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation



class OrderShopify {
    var id : Int = 0//2036009369653
    var status = "Received"
    var name = ""

    init(){
        
    }
    
    init(json: [String: AnyObject]) {
            print(json)
            if let id = json["id"] as? Int {
                self.id = id
            }
        
        if let name = json["name"] as? String {
            self.name = name
        }
        
       
        if let notes = json["note_attributes"] as? [AnyObject]{
            
            print(notes)
            
            for note in notes {
                if let modelNote = note as? [String:String] {
                    if modelNote["name"] == "status" {
                        if let status = modelNote["value"] as? String {
                            self.status = status
                        }
                    }
                }
            }
        }
    }

}
class MyOrder {
    
    private static var sharedMyOrder: MyOrder = {
           let shared = MyOrder()
           return shared
       }()
    
    var order = OrderShopify()

 
    
    init(){
        
    }
    
    class func shared() -> MyOrder {
           return sharedMyOrder
    }
    
    func finish(){
        self.order.id = 0
    }
    
    func isEmpy()->Bool{
        if self.order.id == 0 {return true}
        return false
    }
    
    func myOrderNumber()->String{
        return "\(self.order.name)"
    }
       

   
}
