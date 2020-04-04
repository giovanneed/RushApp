//
//  Item.swift
//  Rush
//
//  Created by gio emiliano on 2020-02-18.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation


class Item  {
    
    
    var selectedToOrder = false
    
    var quantity : Int = 1
    var name = ""
    var price = 0.00
    var calories = 150
    var mainImage = ""
    var newPrice = 0.00
    
    var extras : [Extra] = []
    var sizes : [Size] = []

    init(){
        
    }
    
    func updatePrice(add delta: Int) {
        
    }
    func selectedSize()->Size{
        
        for size in sizes {
            if size.selected {
               return size
            }
        }
        
        return Size()
        
    }
    func formattedSize()->String {
         
        return "\(self.selectedSize().title)"
    }
    
    func formattedPrice()->String {
                
        return "$ \(fullPrice())"
    }
    
    func fullPrice()->Double {
        return (self.selectedSize().price + extrasSelectedPrice()) * Double(quantity)
    }
    
    func extrasSelectedPrice()->Double {
        var extrasPrice : Double = 0.0
        
        for extra in extras {
            if extra.selected {
                extrasPrice = extrasPrice + extra.price
            }
        }
        
        return extrasPrice
    }
    
    func formattedQuantity()->String {
                   
           return "x \(quantity)"
       }
    
    func formattedNewPrice()->String {
        
        return "$ \(newPrice)"
    }
    
    
    func formattedCal()->String {
          
          return "\(self.selectedSize().calories) kCal"
    }
    
    func formattedExtras()->String {
        var extrasText = ""
        for extra in extras {
            if extra.selected {
                if extrasText == "" {
                    extrasText = extra.title
                } else {
                    extrasText = extrasText + ", " + extra.title
                }
            }
        }
        
        return extrasText
    }
    
    func formattedTitle()->String {
           
        return "\(quantity) x \(selectedSize().title) \(name)"
           
    }
    
}
