//
//  MyOrderViewController.swift
//  Rush
//
//  Created by gio emiliano on 2020-02-04.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit


class MyOrderViewController : UIViewController {
    
    @IBOutlet weak var viewTotal: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
        viewTotal.materialCardLayout()
        
        fechTotal()
        
    }
    
    func fechTotal(){
        totalLabel.text = ShoppingCart.shared().priceTotal()

    }
    
    @IBAction func payment(_ sender: Any) {
        performSegue(withIdentifier: "SeguePayment", sender: nil)
    }
    
}


extension MyOrderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingCart.shared().products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell") as! OrderItemTableViewCell
        let product = ShoppingCart.shared().products[indexPath.row]
        cell.delegate = self
        cell.setup(product: product, indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 144// UITableView.automaticDimension
       }
    
    
}


extension MyOrderViewController: OrderItemeCellDelegate {
    func removeItem(_ item: Item, indexPath: IndexPath) {

        CurrentOrder.shared().removeItem(item)
        if  CurrentOrder.shared().order.items.count < 1 {
            itemsTableView.reloadData()
            self.navigationController?.popViewController(animated: true)
            return
        }
        itemsTableView.deleteRows(at: [indexPath], with: .fade)
        
      
        fechTotal()
       
//        for itemSaved in CurrentOrder.shared().order.items {
//            if item === itemSaved {
//                itemSaved.
//            }
//        }
        
        
    }
}
