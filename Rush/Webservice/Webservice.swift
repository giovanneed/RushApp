//
//  Webservice.swift
//  Rush
//
//  Created by gio emiliano on 2020-02-04.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation




class Webservice {
    
   static let sharedWebservice = Webservice(baseURL: "http://localhost:3000/")

     
    let baseURL: String

    
    init(baseURL: String) {
        self.baseURL = baseURL

    }
    
    class func shared() -> Webservice {
           return sharedWebservice
    }
    
    private func requestWithURI(_ URI : String, httpVerb: String)-> URLRequest? {
        
        let stringURL =  baseURL + URI
        if let url = URL(string:stringURL) {
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = httpVerb
            
            return request as URLRequest
        }
        
        return nil
            
        
    }
    
    
     func getAllPlaces(callback: @escaping(_ places: [Place], _ error: Error?) -> Void  ){
        
        
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

        
    
        callback(places,nil)

        
    }
    
    
    func getPlaces() {
        
        guard let request = requestWithURI("restaurants", httpVerb: "GET") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                          
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            guard let data = data else {
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [Any] else {
                print("Not containing JSON")
                return
            }
            
            for place in json {
                print(place)
                if let object = place as? [String : Any] {
                    
                    print(object["address"])
                }
                
            }

          //  print(json)

            
//            do {
//                if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
//                    // Print out dictionary
//                    print(convertedJsonIntoDict)
//                }
//            } catch let error as NSError {
//                print(error.localizedDescription)
//            }
//
            
            if  let responseString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
                
                print(responseString)

                
            }
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(jsonResult)
                    
                    //onSuccess(characater)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
                              
        }
                      
        task.resume()
        
    }
    
    func helloWorld(){
       let helloWorldURL =  baseURL +  "helloworld"
        let url = URL(string:helloWorldURL)
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                   
                   guard error == nil && data != nil else {                                                          // check for fundamental networking error
                       print("error=\(error)")
                       return
                   }
                   
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                       print("statusCode should be 200, but is \(httpStatus.statusCode)")
                       print("response = \(response)")
                   }
                   
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                   
                   
                   
                   print("responseString = \(responseString)")
                   
                   
                   do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                           print(jsonResult)

                       }
                   } catch let error as NSError {
                       print(error.localizedDescription)
                   }
                   
               }
               
               task.resume()


    }
    
}
