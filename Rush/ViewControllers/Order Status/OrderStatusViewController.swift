//
//  OrderStatusViewController.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-13.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

class OrderStatusViewController: UIViewController {

    @IBOutlet weak var viewRate: UIView!
    @IBOutlet weak var buttonStar0: UIButton!
    @IBOutlet weak var buttonStar1: UIButton!
    @IBOutlet weak var buttonStar2: UIButton!
    @IBOutlet weak var buttonStar3: UIButton!
    @IBOutlet weak var buttonStar4: UIButton!
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var viewStatus: UIView!
    @IBOutlet weak var orderSatus0: UILabel!
    @IBOutlet weak var orderStatus1: UILabel!
    @IBOutlet weak var orderSatatus2: UILabel!
    
    @IBOutlet weak var imageStatus: UIImageView!
   

    @IBOutlet weak var orderNumber: UILabel!
    
    var buffer = ""
    
    var timer  : Timer?

    
    @IBOutlet weak var finishOrderButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewStatus.materialCardLayout()
        self.finishOrderButton.isHidden = true
        viewRate.materialCardLayout()


        // Do any additional setup after loading the view.
    }
    
  
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.orderNumber.text = "Order " + MyOrder.shared().myOrderNumber()
     
        message.isHidden = true
        viewStatus.isHidden = false
        self.updateOrder()

        guard timer == nil else { return }

       timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            self.updateOrder()
        }
        
        self.viewRate.alpha = 0
        
      
        
                   
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer?.invalidate()
         timer = nil
    }
    func updateOrder(){
        
        print("check order")
        
        if MyOrder.shared().isEmpy() {
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
    
    func reset(){
        
        self.finishOrderButton.isHidden = true
        self.imageStatus.animate { (finish) in
            self.imageStatus.image = UIImage(named: "status0")
        }
        self.orderSatus0.animate { (finish) in
            self.orderSatus0.font = UIFont.systemFont(ofSize: 18)
            self.orderSatus0.textColor = .black
        }
        self.orderStatus1.animate { (finish) in
            self.orderStatus1.font = UIFont.systemFont(ofSize: 15)
            self.orderStatus1.textColor = .lightGray
            
        }
        self.orderSatatus2.animate { (finish) in
            self.orderSatatus2.font = UIFont.systemFont(ofSize: 15)
            self.orderSatatus2.textColor = .lightGray
        }
        
        
    }
    
    func checkStatus(order: OrderShopify){
        
        if order.status == buffer {
            return
        } else {
            buffer = order.status
        }
        
        if (order.status == "Confirmed") {
                   
        
                reset()
                
                return
            }
        
        
        if (order.status == "In Progress") {
            self.finishOrderButton.isHidden = true
            self.imageStatus.animate { (finish) in
                self.imageStatus.image = UIImage(named: "status1")
            }
            self.orderSatus0.animate { (finish) in
                   self.orderSatus0.font = UIFont.systemFont(ofSize: 15)
                   self.orderSatus0.textColor = .lightGray
            }
            self.orderStatus1.animate { (finish) in
                self.orderStatus1.font = UIFont.systemFont(ofSize: 18)
                self.orderStatus1.textColor = .black

            }
            self.orderSatatus2.animate { (finish) in
                self.orderSatatus2.font = UIFont.systemFont(ofSize: 15)
                self.orderSatatus2.textColor = .lightGray
            }
                       
    
            
            
            return
        }
        
        if (order.status == "Ready" || order.status == "Done" || order.status == "Closed") {
              
            
            self.imageStatus.animate { (finish) in
                    self.imageStatus.image = UIImage(named: "status2")
                }
                self.orderSatus0.animate { (finish) in
                       self.orderSatus0.font = UIFont.systemFont(ofSize: 15)
                       self.orderSatus0.textColor = .lightGray
                }
                self.orderStatus1.animate { (finish) in
                    self.orderStatus1.font = UIFont.systemFont(ofSize: 15)
                    self.orderStatus1.textColor = .lightGray

                }
                self.orderSatatus2.animate { (finish) in
                    self.orderSatatus2.font = UIFont.systemFont(ofSize: 18)
                    self.orderSatatus2.textColor = .black
                }
            
            self.finishOrderButton.animate { (fisinh) in
                self.finishOrderButton.isHidden = false

            }
                           
        
                
                
                return
            }
        
    }
    
    @IBAction func finish(_ sender: Any) {
        
        
        
        MyOrder.shared().finish()
        message.isHidden = true
        viewStatus.isHidden = true
        reset()

        cleanStar()

        
        UIView.animate(withDuration: 1, animations: {
                  self.viewRate.alpha = 1

              }) { _ in

              }
             
        
        

        
        
    }
    
    
    @IBAction func rate(_ sender: Any) {
        
        guard let button = sender as? UIButton else { return }
        cleanStar()

        if (button == buttonStar0) {
            self.buttonStar0.setImage(UIImage(named: "star-fill"), for: .normal)

        }
        if (button == buttonStar1) {
            self.buttonStar0.setImage(UIImage(named: "star-fill"), for: .normal)
            self.buttonStar1.setImage(UIImage(named: "star-fill"), for: .normal)


        }
        if (button == buttonStar2) {
            self.buttonStar0.setImage(UIImage(named: "star-fill"), for: .normal)
            self.buttonStar1.setImage(UIImage(named: "star-fill"), for: .normal)
            self.buttonStar2.setImage(UIImage(named: "star-fill"), for: .normal)

            
        }
        if (button == buttonStar3) {
            self.buttonStar0.setImage(UIImage(named: "star-fill"), for: .normal)
            self.buttonStar1.setImage(UIImage(named: "star-fill"), for: .normal)
            self.buttonStar2.setImage(UIImage(named: "star-fill"), for: .normal)
            self.buttonStar3.setImage(UIImage(named: "star-fill"), for: .normal)

            
        }
        
        if (button == buttonStar4) {
            self.buttonStar0.setImage(UIImage(named: "star-fill"), for: .normal)
            self.buttonStar1.setImage(UIImage(named: "star-fill"), for: .normal)
            self.buttonStar2.setImage(UIImage(named: "star-fill"), for: .normal)
            self.buttonStar3.setImage(UIImage(named: "star-fill"), for: .normal)
            self.buttonStar4.setImage(UIImage(named: "star-fill"), for: .normal)

            
        }
    }
    
    func cleanStar(){
        self.buttonStar0.setImage(UIImage(named: "star-blank"), for: .normal)
        self.buttonStar1.setImage(UIImage(named: "star-blank"), for: .normal)
        self.buttonStar2.setImage(UIImage(named: "star-blank"), for: .normal)
        self.buttonStar3.setImage(UIImage(named: "star-blank"), for: .normal)
        self.buttonStar4.setImage(UIImage(named: "star-blank"), for: .normal)

    }

    @IBAction func finishRate(_ sender: Any) {
        
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



