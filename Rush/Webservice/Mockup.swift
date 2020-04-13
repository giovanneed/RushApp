//
//  Mockup.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-12.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation


class Mockup {

    
    func fakeItems(){
        
        
              var places : [Place] = []
              
              
              let chinesePlace = Place()
              
              chinesePlace.name = "Chinese Food "
              
              chinesePlace.address = "1280 Markham Rd, Scarborough, ON M1H 3B4"
              chinesePlace.latitude =   43.768102
              chinesePlace.longitude = -79.228223
              chinesePlace.rate = 3
              chinesePlace.logoURL = "chinese-logo"
                     
             
              
              let pizzaPlace = Place()
              
              pizzaPlace.name = "Pizza Place Fakelicious"
              
              pizzaPlace.address = "941 Progress Ave, Scarborough, ON M1G 3T8"
              pizzaPlace.latitude =  43.785328
              pizzaPlace.longitude = -79.226670
              pizzaPlace.rate = 3
              pizzaPlace.logoURL = "pizza-logo"
              
              var coke = Item()
              
              coke.name = "Coca Cola"
              coke.price = 2.00
              coke.calories = 150
              coke.mainImage = "can-coke"
              
              let sizeCoke = Size()
              
              sizeCoke.title = "Regular"
              sizeCoke.calories = 180
              sizeCoke.price = 2.00
              sizeCoke.selected = true
              
              coke.sizes.append(sizeCoke)
              
              pizzaPlace.items.append(coke)

              
              var pizza = Item()
              
              pizza.name = "Pepperoni Pizza"
              pizza.price = 22.30
              pizza.calories = 150
              pizza.mainImage = "pizza-pepperoni"
              
              let extra1 = Extra()
              
              extra1.title = "Ground Beef"
              extra1.calories = 180
              extra1.price = 1.99
              
              let extra2 = Extra()
              
              extra2.title = "Ham"
              extra2.calories = 180
              extra2.price = 1.99
              
              let extra3 = Extra()
              
              extra3.title = "Mild Sauce"
              extra3.calories = 180
              extra3.price = 1.99
              
              pizza.extras.append(extra1)
              pizza.extras.append(extra2)
              pizza.extras.append(extra3)
              
              
              let size1 = Size()
              
              size1.title = "Small"
              size1.calories = 180
              size1.price = 15.50
              
              let size2 = Size()
              
              size2.title = "Medium"
              size2.calories = 180
              size2.price = 17.50
              size2.selected = true
              
              let size3 = Size()
              
              size3.title = "Large"
              size3.calories = 180
              size3.price = 19.50
              
              let size4 = Size()
              
              size4.title = "X-Large"
              size4.calories = 180
              size4.price = 10.50
              
              pizza.sizes.append(size1)
              pizza.sizes.append(size2)
              pizza.sizes.append(size3)
              pizza.sizes.append(size4)

              

              pizzaPlace.items.append(pizza)
              
              
              var pizzaBacon = Item()
              
              pizzaBacon.name = "Pepperoni Bacon"
              pizzaBacon.price = 28.30
              pizzaBacon.calories = 150
              pizzaBacon.mainImage = "pizza-bacon"
              
              pizzaPlace.items.append(pizzaBacon)
              
              var pizzaCheese = Item()
              
              pizzaCheese.name = "Pepperoni Cheese"
              pizzaCheese.price = 20.30
              pizzaCheese.calories = 150
              pizzaCheese.mainImage = "pizza-cheese"
              
              pizzaPlace.items.append(pizzaCheese)
              
              
              var pizzaHawaiian = Item()
              
              pizzaHawaiian.name = "Pepperoni Pizza"
              pizzaHawaiian.price = 29.99
              pizzaHawaiian.calories = 150
              pizzaHawaiian.mainImage = "pizza-hawaiian"
              
              pizzaPlace.items.append(pizzaHawaiian)
              
              
              
              places.append(pizzaPlace)
              places.append(chinesePlace)

              
          
    }
    
}
