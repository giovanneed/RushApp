//
//  PlaceTableViewCell.swift
//  Rush
//
//  Created by gio emiliano on 2020-02-18.
//  Copyright © 2020 Giovanne Emiliano. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    @IBOutlet weak var labelName: UILabel!
    
    @IBOutlet weak var labelAddress: UILabel!
    
    @IBOutlet weak var labelDistance: UILabel!
    
    @IBOutlet weak var labelHours: UILabel!
    
    @IBOutlet weak var rateStar1: UIImageView!
    
    @IBOutlet weak var rateStar2: UIImageView!
    
    @IBOutlet weak var rateStar3: UIImageView!
    
    @IBOutlet weak var rateStar4: UIImageView!
    
    @IBOutlet weak var rateStar5: UIImageView!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var cardBackgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(place: Place) {
        
        labelName.text = place.name
        labelAddress.text = place.address
        logo.image = UIImage(named: place.logoURL)
        logo.layer.cornerRadius = logo.frame.width/2
        cardBackgroundView.materialCardLayout()
//        cardBackgroundView.layer.cornerRadius = 5
//        cardBackgroundView.layer.shadowColor = UIColor.black.cgColor
//        cardBackgroundView.layer.shadowOpacity = 1
//        cardBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 1);
//        cardBackgroundView.layer.shadowRadius = 2
        
    }


}
