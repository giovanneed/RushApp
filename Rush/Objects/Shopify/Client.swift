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
    
    
    var firstName : String = "iOS"
    var lastName : String = "App 222"

 
    
    init(){
        
    }
    
    class func shared() -> Client {
           return sharedClient
    }

   
}
