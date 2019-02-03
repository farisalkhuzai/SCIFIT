//
//  freeExercisesTableCell.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٨ محرم، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit

class freeExercisesTableCell: UITableViewCell {

    @IBOutlet weak var ExerciseCronerIMage: UIImageView!

    @IBOutlet weak var nameOfMucle: UILabel!
    @IBOutlet weak var nameOfExercise: UILabel!
    @IBOutlet weak var exerciseImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ExerciseCronerIMage.layer.cornerRadius = ExerciseCronerIMage.frame.size.width/2
        ExerciseCronerIMage.clipsToBounds = true
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if (nameOfMucle.text == "صدر"){
            ExerciseCronerIMage.image = UIImage(named:"صدر.png")
        }
        else if (nameOfMucle.text == "باي"){
            ExerciseCronerIMage.image = UIImage(named: "باي.png")
        }
        else if (nameOfMucle.text == "بطن"){
            ExerciseCronerIMage.image = UIImage(named:"بطن.png")
        }
        else if(nameOfMucle.text == "بطات"){
            ExerciseCronerIMage.image =  UIImage(named:"بطات.png")
        }
        else if (nameOfMucle.text == "افخاذ"){
            ExerciseCronerIMage.image =  UIImage(named: "افخاذ.png")
        }
        else if (nameOfMucle.text == "اكتاف"){
            ExerciseCronerIMage.image =  UIImage(named:"اكتاف.png")
        }
        else if (nameOfMucle.text == "تراي"){
            ExerciseCronerIMage.image =  UIImage(named:"تراي.png")
        }
        else if (nameOfMucle.text == "ظهر"){
            ExerciseCronerIMage.image =  UIImage(named:"ظهر.png")
        }
        else {
            ExerciseCronerIMage.image = UIImage(named: "questions-circular-button.png")
        }
    }


}
