//
//  trainingCell.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٦ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit

class trainingCell: UITableViewCell {
    
    
    @IBOutlet weak var daysLable: UILabel!
    @IBOutlet weak var exersiceLable: UILabel!
    @IBOutlet weak var numberOfexLable: UILabel!
    
    @IBOutlet weak var dayicon: UIImageView!
    @IBOutlet weak var muscleicon: UIImageView!
    @IBOutlet weak var dumbellicon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
