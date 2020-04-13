//
//  PaynentViewController.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-13.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

class PaynentViewController: UIViewController {
    
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var cardName: UITextField!
    @IBOutlet weak var cardExpDate: UITextField!
    @IBOutlet weak var cardSecCode: UITextField!
    
    @IBOutlet weak var paymentButton: UIButton!
    
    @IBOutlet weak var viewCard: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCard.materialCardLayout()
        
        cardNumber.text = Client.shared().cardNumber
        cardName.text = Client.shared().cardName
        cardExpDate.text = Client.shared().cardExpDate
        cardSecCode.text = Client.shared().cardSecCode

        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func pay(_ sender: Any) {
        
//        Your order’s being processed.
//        If you’re not automatically redirected, refresh this page.
//        
//        Your order is confirmed
        
        
        self.loading(show: true)
        authorize()

      
        
    }
    
    func authorize(){
        //  Just create your alert as usual:
        let alertView = UIAlertController(title: "Please wait", message: "Your order’s being processed.", preferredStyle: .alert)

        //  Show it to your users
        present(alertView, animated: true, completion: {
            //  Add your progressbar after alert is shown (and measured)
           
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Change `2.0` to the desired number of seconds.
            
           // Code you want to be delayed
            Webservice.shared().createOrder { (order, error) in
                if let order = order {
                    MyOrder.shared().order = order
                    print(MyOrder.shared().order.id)
                    DispatchQueue.main.async {
                        self.dismiss(animated: true, completion: nil)
                        self.orderConfirmation()
                    }
                    
                }
            }

        }
    }
    
    func orderConfirmation(){
        
        self.loading(show: false)
        
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
