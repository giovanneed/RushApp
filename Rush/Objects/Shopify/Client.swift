//
//  Client.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-13.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
class Client {
    
    private static var sharedClient: Client = {
           let shared = Client()
           return shared
       }()
    
    
    var firstName : String = "Ashley"
    var lastName : String = "Graham"

    var cardNumber: String = "1"
    var cardName: String = "Bogus Gateway"
    var cardExpDate: String = "06/21"
    var cardSecCode: String = "123"

 
    
    init(){
        
    }
    
    class func shared() -> Client {
           return sharedClient
    }

   
}
