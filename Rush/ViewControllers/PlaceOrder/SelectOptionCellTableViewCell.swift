//
//  SelectOptionCellTableViewCell.swift
//  Rush
//
//  Created by gio emiliano on 2020-04-03.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

protocol SelectOptionCellDelegate: class {
  
    func selectSize(_ size: Size)
}

class SelectOptionCellTableViewCell: UITableViewCell {
    
    
    var size = Size()
    
    var delegate : SelectOptionCellDelegate?

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var extraDetailLabel: UILabel!
    @IBOutlet weak var selectButton: SelectButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    @IBAction func selectOption(_ sender: Any) {
        delegate?.selectSize(size)
    }
    
    
    func setup(size: Size) {
        self.size = size
        titleLabel.text = size.title
        detailLabel.text = size.formattedCal()
        extraDetailLabel.text = size.formattedPrice()
        checkStatus()
    }
    
    func checkStatus(){
            selectButton.selectedStatus = size.selected
            selectButton.checkedStatus()
    }

}
