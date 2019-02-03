//
//  dailymealTableViewCell.swift
//  vegoLogo
//
//  Created by Faris Alkhuzai on 09/11/1439 AH.
//  Copyright © 1439 Khaled Kutbi. All rights reserved.
//

import UIKit

class dailymealTableViewCell: UITableViewCell {

    @IBOutlet weak var calImage: UIImageView!
    @IBOutlet weak var calLable: UILabel!
    @IBOutlet weak var plateImage: UIImageView!
    @IBOutlet weak var mealsLable: UILabel!
    @IBOutlet weak var mealImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        // Configure the view for the selected state
    }

}
