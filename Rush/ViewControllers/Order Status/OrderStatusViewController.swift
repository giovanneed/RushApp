//
//  OrderStatusViewController.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-13.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

class OrderStatusViewController: UIViewController {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var orderSatus0: UILabel!
    @IBOutlet weak var orderStatus1: UILabel!
    @IBOutlet weak var orderSatatus2: UILabel!
    
    @IBOutlet weak var check0: UIImageView!
    
    @IBOutlet weak var check1: UIImageView!
    
    @IBOutlet weak var check2: UIImageView!
    

    
    @IBOutlet weak var finishOrderButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStatus.materialCardLayout()
        self.updateOrder()

     

        
       

        // Do any additional setup after loading the view.
    }
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            self.updateOrder()
        }
   
                   
        
    }
    
    func updateOrder(){
        
        print("check order")
        
        if MyOrder.shared().order.id == 0 {
            message.isHidden = false
            viewStatus.isHidden = true
        } else {
            message.isHidden = true
            viewStatus.isHidden = false
            Webservice.shared().getOrderByID(orderID: MyOrder.shared().order.id) { (order, error) in
                
                if let myOrder = order {
                    print(myOrder.status)
                    DispatchQueue.main.async() {
                        self.checkStatus(order: myOrder)
                        
                    }
                }
            }
            
        }
        
       
    }
    
    func checkStatus(order: OrderShopify){
        
        if (order.status == "Confirmed") {
            return
        }
        
        if (order.status == "In Progress") {
            
            check0.image = UIImage(systemName: "checkmark.circle.fill")
            check1.image = UIImage(systemName: "checkmark.circle.fill")
            check2.image = UIImage(systemName: "circle")
            
            return
        }
        
        if (order.status == "Ready" || order.status == "Done" || order.status == "Closed") {
            
            check0.image = UIImage(systemName: "checkmark.circle.fill")
            check1.image = UIImage(systemName: "checkmark.circle.fill")
            check2.image = UIImage(systemName: "checkmark.circle.fill")
            
            return
        }
    }
    @IBAction func finish(_ sender: Any) {
        
        MyOrder.shared().finish()
        updateOrder()
        self.tabBarController?.selectedIndex = 0
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
