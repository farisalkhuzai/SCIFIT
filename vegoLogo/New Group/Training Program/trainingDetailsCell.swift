//
//  trainingDetailsCell.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٩ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit

class trainingDetailsCell: UITableViewCell {
    
    
    
    
    //    @IBOutlet weak var numberofExersiceLable: UILabel!
    //    @IBOutlet weak var typeOfexersiceLable: UILabel!
    //    @IBOutlet weak var exersiceLable: UILabel!
    @IBOutlet weak var ExerciseCronerIMage: UIImageView!
    
    
    @IBOutlet weak var targetedexer: UILabel!
    @IBOutlet weak var exername: UILabel!
    @IBOutlet weak var exernumber: UILabel!
    @IBOutlet weak var exerImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ExerciseCronerIMage.layer.cornerRadius = ExerciseCronerIMage.frame.size.width/2
        ExerciseCronerIMage.clipsToBounds = true
      

    }
    
       
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if (targetedexer.text == "صدر"){
            ExerciseCronerIMage.image = UIImage(named:"صدر.png")
        }
        else if (targetedexer.text == "باي"){
            ExerciseCronerIMage.image = UIImage(named: "باي.png")
        }
        else if (targetedexer.text == "بطن"){
            ExerciseCronerIMage.image = UIImage(named:"بطن.png")
        }
        else if(targetedexer.text == "بطات"){
            ExerciseCronerIMage.image =  UIImage(named:"بطات.png")
        }
        else if (targetedexer.text == "افخاذ"){
            ExerciseCronerIMage.image =  UIImage(named: "افخاذ.png")
        }
        else if (targetedexer.text == "اكتاف"){
            ExerciseCronerIMage.image =  UIImage(named:"اكتاف.png")
        }
        else if (targetedexer.text == "تراي"){
            ExerciseCronerIMage.image =  UIImage(named:"تراي.png")
        }
        else if (targetedexer.text == "ظهر"){
            ExerciseCronerIMage.image =  UIImage(named:"ظهر.png")
        }
        else {
            ExerciseCronerIMage.image = UIImage(named: "questions-circular-button.png")
        }
    }

}
