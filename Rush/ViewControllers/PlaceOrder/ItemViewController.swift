//
//  ItemViewController.swift
//  Rush
//
//  Created by gio emiliano on 2020-02-18.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet weak var tableDetails: UITableView!
    
    
    @IBOutlet weak var backgroundTable: UIView!
    var item = Item()
    
    var deltaPrice = 0.00
    
    @IBOutlet weak var itemImage: UIImageView!
    
    @IBOutlet weak var itemLabelName: UILabel!
    @IBOutlet weak var itemLabelCalories: UILabel!
    
    @IBOutlet weak var itemLabelPrice: UILabel!
    
    @IBOutlet weak var itemLabelSize: UILabel!
    
    @IBOutlet weak var itemLabelNumberOfItems: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableDetails.delegate = self
        tableDetails.dataSource = self
        tableDetails.register(MyCustomHeader.self,
                              forHeaderFooterViewReuseIdentifier: "sectionHeader")

        // Do any additional setup after loading the view.
       
        
        backgroundTable.materialCardLayout()
        
        
        if item.extras.count == 0 && item.sizes.count < 2 {
            backgroundTable.isHidden = true
        }
        

        retriveItemInfo()
    

        
    }
  
    
    func retriveItemInfo(){
        
        itemImage.image = UIImage(named: item.mainImage)
        itemLabelName.text = item.name
        itemLabelCalories.text = item.formattedCal()
        
        itemLabelPrice.text = item.formattedPrice()//"CAD \(item.price  + deltaPrice)" //item.price  + deltaPrice
        itemLabelSize.text = item.formattedSize()
        itemLabelNumberOfItems.text = item.formattedQuantity()


    }
    
    @IBAction func increaseItem(_ sender: Any) {
        
        self.item.quantity += 1
        
        retriveItemInfo()
    
    }
    @IBAction func decreaseItem(_ sender: Any) {
        
        if self.item.quantity > 1 {
            self.item.quantity -= 1
        }
        
        retriveItemInfo()

    }
    
    
    
    
    @IBAction func addOrder(_ sender: Any) {
        item.newPrice = item.price  + deltaPrice
        item.selectedToOrder = true 
        CurrentOrder.shared().order.items.append(self.item)
        
        dismiss(animated: true, completion: nil)

        
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

extension ItemViewController: UITableViewDelegate, UITableViewDataSource{
    
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return item.sizes.count
        case 1:
            return item.extras.count 

        default:
            return 0
        }
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                return selectOptionCell(withRow: indexPath.row, tableView: tableView)
            case 1:
                return checkExtraCell(withRow: indexPath.row, tableView: tableView)
            default:
                return UITableViewCell()
            
        }
       }
    
    
    func selectOptionCell(withRow row: Int, tableView: UITableView)->SelectOptionCellTableViewCell{
           
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectOptionCellTableViewCell") as! SelectOptionCellTableViewCell
        let size = item.sizes[row]
        cell.setup(size: size)
        cell.delegate = self
        
        return cell
        
       }
    
    
    func checkExtraCell(withRow row: Int, tableView: UITableView)->CheckExtraTableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckExtraCell") as! CheckExtraTableViewCell
        let extra = item.extras[row]
        
        cell.setup(extra: extra)
        cell.delegate = self
        
        return cell
        
    }
       
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
              return 90
          }
    
     func tableView(_ tableView: UITableView,
            viewForHeaderInSection section: Int) -> UIView? {
       let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                   "sectionHeader") as! MyCustomHeader
      //bre view.title.text = "Extras"//sections[section]
      // view.image.image = UIImage(named: sectionImages[section])
        
        switch section {
        case 0:
            if (item.sizes.count < 1) { return nil }
            view.title.text = "Size"
        case 1:
            if (item.extras.count < 1) { return nil }
            view.title.text = "Extras"
        default:
            break
        }
        

       return view
    }
}

extension ItemViewController: CheckExtraCellDelegate,SelectOptionCellDelegate{
    func selectSize(_ size: Size) {
        for option in item.sizes {
            if size === option {
                option.selected = true
            } else {
                option.selected = false
            }
        }
        
    
        
        
        tableDetails.reloadData()
        retriveItemInfo()
                
    }
    
    func checkExtra(_ extra: Extra) {
        
        for option in item.extras {
            if extra === option {
                if option.selected == true {
                    option.selected = false
                } else {
                    option.selected = true
                }
            }
        }

        tableDetails.reloadData()
        retriveItemInfo()
        
    }

}





class MyCustomHeader: UITableViewHeaderFooterView {
    let title = UILabel()
    let image = UIImageView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        image.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(image)
        contentView.addSubview(title)

        // Center the image vertically and place it near the leading
        // edge of the view. Constrain its width and height to 50 points.
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            image.widthAnchor.constraint(equalToConstant: 50),
            image.heightAnchor.constraint(equalToConstant: 50),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        
            // Center the label vertically, and use it to fill the remaining
            // space in the header view.
            title.heightAnchor.constraint(equalToConstant: 30),
            title.leadingAnchor.constraint(equalTo: image.trailingAnchor,
                   constant: 8),
            title.trailingAnchor.constraint(equalTo:
                   contentView.layoutMarginsGuide.trailingAnchor),
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
