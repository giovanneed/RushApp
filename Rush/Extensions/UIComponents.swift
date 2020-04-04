//
//  UIComponents.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-03.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import Foundation
import UIKit

class MaterialView : UIView {
    
    required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()

    }
    
    func setup(){
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 1);
        self.layer.shadowRadius = 2
        self.backgroundColor = .white

    }
    

    
}

class QuantityButton : UIButton {
      
      required init?(coder aDecoder: NSCoder) {
             super.init(coder: aDecoder)
             
          setup()
      }
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          setup()

      }
      
      func setup(){
          backgroundColor = Colors().mainOrange
          layer.borderWidth = 1
          layer.borderColor = Colors().mainOrange.cgColor
        titleLabel?.textColor = Colors().white
        tintColor = Colors().white
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
      }
      
    
}


class RoundedButton : UIButton {
      
      required init?(coder aDecoder: NSCoder) {
             super.init(coder: aDecoder)
             
          setup()
      }
      
      override init(frame: CGRect) {
          super.init(frame: frame)
          setup()

      }
      
      func setup(){
          backgroundColor = Colors().mainOrange
          layer.borderWidth = 1
          layer.borderColor = Colors().mainOrange.cgColor
        titleLabel?.textColor = Colors().white
        tintColor = Colors().white
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.layer.cornerRadius = self.frame.width/2

      }
      
    
}
