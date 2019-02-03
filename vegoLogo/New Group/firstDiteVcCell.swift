//
//  firstDiteVcCell.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٣ محرم، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit

class firstDiteVcCell: UITableViewCell {

    
    @IBOutlet weak var calenderImage: UIImageView!
    @IBOutlet weak var daysLable: UILabel!
    @IBOutlet weak var calImage: UIImageView!
    @IBOutlet weak var calLable: UILabel!
    @IBOutlet weak var plateImage: UIImageView!
    @IBOutlet weak var mealsLable: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
