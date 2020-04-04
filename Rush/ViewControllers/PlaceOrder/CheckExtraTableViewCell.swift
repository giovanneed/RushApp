//
//  CheckExtraTableViewCell.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-03.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit


protocol CheckExtraCellDelegate: class {
  
    func checkExtra(_ extra: Extra)
}

class CheckExtraTableViewCell: UITableViewCell {
    
    var extra = Extra()
    
    var delegate : CheckExtraCellDelegate?
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var extraDetailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var checkButton: CheckButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(extra: Extra) {
        titleLabel.text = extra.title
        detailLabel.text = extra.formattedCal()
        extraDetailLabel.text = extra.formattedPrice()

        self.extra = extra
        print(extra.title)
      
        checkStatus()
    }
    @IBAction func checked(_ sender: Any) {
        delegate?.checkExtra(extra)
    }
    
    func checkStatus(){
        checkButton.selectedStatus = extra.selected
        checkButton.checkedStatus()
    }
    
}
