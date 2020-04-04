//
//  Extensions.swift
//  Rush
//
//  Created by gio emiliano on 2020-02-18.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    
    func materialCardLayout() {
        
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 1);
        self.layer.shadowRadius = 2
        self.backgroundColor = .white
    }
    
    func roundedView() {
          self.layer.cornerRadius = self.frame.width/2

      }
    
}

extension UIImageView {
    func rounded() {
        self.layer.cornerRadius = self.frame.width/2
        self.contentMode = .scaleAspectFill

    }
}


class rushButton : UIButton {
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           
        backgroundColor = Colors().mainOrange
        layer.cornerRadius = 5
        self.setTitleColor(Colors().white, for: .normal)
        self.titleLabel?.font =  UIFont(name: "", size: 25)



       }
    
}


class radioButton : UIButton {
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           
        backgroundColor = Colors().white
        layer.borderWidth = 1
        layer.borderColor = Colors().mainOrange.cgColor
        layer.cornerRadius = frame.width/2
    }
    
}


class SelectButton : UIButton {
    
    var selectedStatus = false

    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           
        backgroundColor = Colors().white
        layer.borderWidth = 1
        layer.borderColor = Colors().mainOrange.cgColor
        layer.cornerRadius = frame.width/2
        
        checkedStatus()

    }
    
    
    func checkedStatus(){
           backgroundColor = selectedStatus ? Colors().mainOrange : Colors().white
       }
}




class CheckButton : UIButton {
    
    var selectedStatus = false
    
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

    }
    
    func setup(){
        backgroundColor = Colors().white
        layer.borderWidth = 1
        layer.borderColor = Colors().mainOrange.cgColor
        checkedStatus()
    }
    
    func checkedStatus(){
        backgroundColor = selectedStatus ? Colors().mainOrange : Colors().white
    }
    func clicked(){
        
        if selectedStatus == false {
            selectedStatus = true

        } else {
            selectedStatus = false
        }
        
        checkedStatus()
        
    }
    
}

