//
//  CheckList.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-02.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

protocol CheckExtraDelegate: class {
  
    
    func checkExtra(extra: Extra)

    
}


class CheckList: UIView {
    
    var delegate : CheckExtraDelegate?

    
    var expanded = false
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelSelected: UILabel!
    @IBOutlet weak var buttonExpand: UIButton!
    
    var extras : [Extra] = []
    

    @IBOutlet var contentView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()

    }
    
    
    private func commonInit(){
        let nib = UINib(nibName: "CheckListView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
              contentView.frame = bounds
              addSubview(contentView)

    }
    
    @IBAction func showOptions(_ sender: Any) {
        
        if expanded == false {
            expanded = true
            self.frame.size.height = 1000
            
            for i in 0..<extras.count {
                addSubview(self.createView(i, extra: extras[i]))
            }
          
        } else {
            self.frame.size.height = 200
            expanded = false
            for view in self.subviews {
                if view.tag>0 {
                    view.removeFromSuperview()

                }
            }

        }
        
        
    }
    
    func setup(_ title:String, options: [Extra]){
        self.extras = options
        self.labelTitle.text = title
        self.labelSelected.text = ""
        backgroundColor = .green
    }
    
    func createView(_ xDelta: Int, extra: Extra)->UIView {
        
        
        let w = self.frame.width
        let xRef = 72 * (xDelta + 1)
        let viewOption = UIView(frame: CGRect(x: 20, y: xRef, width: Int(w - 40), height: 70))
        let subW = viewOption.frame.width

        
        let labelItemTitle  = UILabel(frame: CGRect(x:20, y:10, width: w-40, height: 22))
        labelItemTitle.text = extra.title
        viewOption.addSubview(labelItemTitle)
        
        let detailItemTitle  = UILabel(frame: CGRect(x:20, y:40, width: w-40, height: 22))
        detailItemTitle.text = "this is details"
        viewOption.addSubview(detailItemTitle)
        
        let checkButton = CheckButton(frame: CGRect(x: subW - 60, y:viewOption.frame.height/2 - 15, width: 30, height: 30))
        
        checkButton.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
        checkButton.selectedStatus = extra.selected
        
        viewOption.tag = 10 + xDelta
        checkButton.tag = viewOption.tag
        viewOption.addSubview(checkButton)
        
        viewOption.backgroundColor = .red
        
        return viewOption
    }
    
    @objc func didButtonClick(_ sender: CheckButton) {
        let i = sender.tag - 10
        let extra = extras[i]
        if extra.selected == true {
            extra.selected = false
        } else {
            extra.selected = true
        }
        delegate?.checkExtra(extra: extra)
        sender.clicked()
        // your code goes here
    }

}
