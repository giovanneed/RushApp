//
//  PaynentViewController.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-13.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

class PaynentViewController: UIViewController {
    
    @IBOutlet weak var cardNumber: UIView!
    @IBOutlet weak var cardName: UITextField!
    @IBOutlet weak var cardExpDate: UITextField!
    @IBOutlet weak var cardSecCode: UITextField!
    
    @IBOutlet weak var paymentButton: UIButton!
    
    @IBOutlet weak var viewCard: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCard.materialCardLayout()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pay(_ sender: Any) {
        
//        Your order’s being processed.
//        If you’re not automatically redirected, refresh this page.
//        
//        Your order is confirmed
        

        Webservice.shared().createOrder { (order, error) in
            if let order = order {
                MyOrder.shared().order = order
                print(MyOrder.shared().order.id)
                DispatchQueue.main.async {
                    self.orderConfirmation()
                }
                
            }
        }
        
    }
    
    func orderConfirmation(){
        
        let alert = UIAlertController(title: "Order", message: "Your order is confirmed.", preferredStyle: .alert)

       alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        ShoppingCart.shared().reset()
        
        for controller in self.navigationController!.viewControllers as Array {
            print(controller)
            if controller.isKind(of: UITabBarController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
        }))
        self.present(alert, animated: true)
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
