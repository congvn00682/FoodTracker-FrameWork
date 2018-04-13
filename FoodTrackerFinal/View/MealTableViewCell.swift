//
//  MealTableViewCell.swift
//  FoodTrackerFinal
//
//  Created by Vu Ngoc Cong on 4/13/18.
//  Copyright © 2018 Vu Ngoc Cong. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    

}
