//
//  Extra.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-02.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation


class Extra {
    
    var selected = false
    
    var title = ""
    var detail = ""

    var price = 0.00
    var calories = 150

    
    init(){
        
    }
    
    func formattedPrice()->String {
        
        return "+ $\(price)"
    }
    
    func formattedCal()->String {
          
          return "\(calories) kCal"
    }
    
   
}
