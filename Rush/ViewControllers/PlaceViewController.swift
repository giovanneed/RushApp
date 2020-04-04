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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        
        viewPlace.materialCardLayout()
    }
    
    @IBAction func showMyOrder(_ sender: Any) {
        if  CurrentOrder.shared().order.items.count > 0 {

            performSegue(withIdentifier: "MyOrderSegue", sender: nil)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        return place.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCollectionViewCell
        
        let item = place.items[indexPath.row]
        cell.setup(item: item)
        // Configure the cell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 180, height: 270)
       }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = place.items[indexPath.row]

        performSegue(withIdentifier: "SegueItemDetail", sender: item)
    }
    
    
    
    
    
    
    
}
