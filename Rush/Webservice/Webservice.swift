//
//  Webservice.swift
//  Rush
//
//  Created by gio emiliano on 2020-02-04.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation




class Webservice {
   
   static let localhost = "http://localhost:3000"
   static let aws = "http://3.16.149.130:3000"
   static let sharedWebservice = Webservice(baseURL:localhost)

     
    let baseURL: String

    
    init(baseURL: String) {
        self.baseURL = baseURL

    }
    
    class func shared() -> Webservice {
           return sharedWebservice
    }
    
   
    private func requestWithURI(_ URI : String, httpVerb: String)-> URLRequest? {
        
        let stringURL =  baseURL + URI
        
        print(stringURL)
        
        if let url = URL(string:stringURL) {
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = httpVerb
          

            
            return request as URLRequest
        }
        
        return nil
            
        
    }
    func getOrderByID(orderID: Int, callback: @escaping(_ order: OrderShopify?, _ error: Error?) -> Void){
        guard let request = requestWithURI("/shopify/orders/\(orderID)", httpVerb: "GET") else {
                   return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(String(describing: error))")
                callback(nil,error)
                
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                // print("response = \(response)")
            }
            
            guard let data = data else {
                callback(nil,error)
                
                return
            }
                              
            
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(jsonResult)
                    
                    
                        if let modelOrder = jsonResult["order"] as? [String:AnyObject] {
                            let order = OrderShopify(json: modelOrder)
                            callback(order,nil)
                        }
                    
                    
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                callback(nil,error)

            }

            
        }


        task.resume()
        
        
    }
    func createOrder(callback: @escaping(_ order: OrderShopify?, _ error: Error?) -> Void  ){
        
        guard var request = requestWithURI("/shopify/orders", httpVerb: "POST") else {
            return
        }
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let parameters = ShoppingCart.shared().orderToJSON()
        
        print(parameters)
        
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(String(describing: error))")
                callback(nil,error)
                
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                // print("response = \(response)")
            }
            
            guard let data = data else {
                callback(nil,error)
                
                return
            }
                              
            
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print(jsonResult)
                    
                    if let body = jsonResult["body"] as? [String:AnyObject]  {
                        if let modelOrder = body["order"] as? [String:AnyObject] {
                            let order = OrderShopify(json: modelOrder)
                            callback(order,nil)
                        }
                    }
                    
                    
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                callback(nil,error)

            }

            
        }


        task.resume()

        
    }
    func getProducts(callback: @escaping(_ products: [Product], _ error: Error?) -> Void  ){
        
         
        
        guard let request = requestWithURI("/shopify/products", httpVerb: "GET") else {
                   return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
                    var products : [Product] = []

                                 
                   guard error == nil && data != nil else {                                                          // check for fundamental networking error
                       print("error=\(String(describing: error))")
                       callback(products,error)

                       return
                   }
                   
                   guard let data = data else {
                        callback(products,error)

                       return
                   }
                   
                  /* guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [Any] else {
                       print("Not containing JSON")
                       return
                   }*/
            

            
                    do {
                        if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            print(jsonResult)
                            
                            if let modelProducts = jsonResult["products"] as? Array<Any> {
                                for modelProduct in modelProducts {
                                    if let parsedModelProduct = modelProduct as? [String: AnyObject] {
                                        print(parsedModelProduct)
                                        let product = Product(json: parsedModelProduct)
                                        products.append(product)
                                    }
                                }
                            }
                            
                            callback(products,nil)
   
                        }
                    } catch let error as NSError {
                        print(error.localizedDescription)
                    }
            
            
        }
           
        
        task.resume()

           
              
       
    }
       
    
 
    
    
     func getAllPlaces(callback: @escaping(_ places: [Place], _ error: Error?) -> Void  ){

        
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
    
    

   
    func shopify(){
        
         let urlString  = "https://45e07faf7bc41c6e83182f3af6a62a17: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@centennial-capstone-store.myshopify.com/admin/api/2020-04/products.json"
        
       let helloWorldURL = urlString
        let url = URL(string:helloWorldURL)
        
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                   
                   guard error == nil && data != nil else {                                                          // check for fundamental networking error
                      // print("error=\(error)")
                       return
                   }
                   
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                       print("statusCode should be 200, but is \(httpStatus.statusCode)")
                      // print("response = \(response)")
                   }
                   
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                   
                   
                   
                   print("responseString = \(responseString)")
                   
                   
                   do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                           print(jsonResult)
                        
                        
                        
                       /* for modelProduct in jsonResult.value(forKey: "products"){
                            print(modelProduct)
                        }*/

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
