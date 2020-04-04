//
//  Place.swift
//  Rush
//
//  Created by gio emiliano on 2020-02-04.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit
import MapKit


class Place {
    
    var items : [Item] = []
    
    var name = ""
    var address = ""
    var latitude : Double = 43.785309
    var longitude : Double = -79.226384
    var logoURL = ""
    var rate = 0
    var annotation : MKAnnotationView = MKAnnotationView()
    
    init(){
        
    }
    
    
    func setup(){
        
        
    }

    
    init(model : NSDictionary)
      {
          
//          //print(model.valueForKeyPath("data.results.thumbnail.path")!.objectAtIndex(0))
//
//          name = model.valueForKeyPath("data.results.name")!.objectAtIndex(0) as! String
//
//          id = model.valueForKeyPath("data.results.id")!.objectAtIndex(0)  as! Int // model.valueForKeyPath("id")  as! Int //["id"] as! Int
//          let urlThumbnail  = model.valueForKeyPath("data.results.thumbnail.path")!.objectAtIndex(0) as! String
//          let extensionThumbnail  = model.valueForKeyPath("data.results.thumbnail.extension")!.objectAtIndex(0) as! String
//          thumbnailURL = urlThumbnail + "." + extensionThumbnail
//          print(thumbnailURL)
//         // name = model[name] as! String
      }
    
}


