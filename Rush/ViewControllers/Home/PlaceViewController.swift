//
//  PlaceViewController.swift
//  Rush
//
//  Created by gio emiliano on 2020-02-04.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit


class PlaceViewController : UIViewController {
    
    @IBOutlet weak var myOrderButton: UIBarButtonItem!
    
    var place = Place()
    
    @IBOutlet weak var itemsCollectionView: UICollectionView!
    
    
    @IBOutlet weak var viewPlace: UIView!
    
    var products : [Product] = []
    
    var bufferCount = 0
    
    var timer  : Timer?


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        
        viewPlace.materialCardLayout()
        
        guard timer == nil else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
            self.retriveProducts()
        }
        
        self.retriveProducts()

     
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           

    }
    
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(true)
          timer?.invalidate()
           timer = nil
      }
       
    
    func retriveProducts(){
        
        Webservice.shared().getProducts { (products, error) in
            if error != nil {
                return
            }
            
            if self.bufferCount == products.count{
                
            } else {
                self.products = products
                self.bufferCount = products.count
                DispatchQueue.main.async {
                              self.itemsCollectionView.reloadData()
                          }
                          
            }
            
          
        }
    }
    
    @IBAction func showMyOrder(_ sender: Any) {
        if  CurrentOrder.shared().order.items.count > 0 {

            performSegue(withIdentifier: "MyOrderSegue", sender: nil)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        
     
        
        
        if segue.identifier == "SegueProductDetail" {
            if let productViewController = segue.destination as? ProductViewController {
                if let product = sender as? Product {
                    productViewController.product = product
                    
                }
            }
        }
    
        if segue.identifier == "SegueItemDetail" {
            if let itemViewController = segue.destination as? ItemViewController {
                if let item = sender as? Item {
                    itemViewController.item = item

                }
            }
        }
    }
}



extension PlaceViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count//place.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCollectionViewCell
        
        let product = products[indexPath.row]
        cell.setup(product: product)
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 180, height: 270)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = products[indexPath.row]

        performSegue(withIdentifier: "SegueProductDetail", sender: product)
    }
    
    
    
    
    
    
    
}
