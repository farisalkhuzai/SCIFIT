//
//  setsCell.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢٣ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit

class setsCell: UITableViewCell , UITextFieldDelegate{
    
    @IBOutlet weak var setsnumber: UILabel!
    @IBOutlet weak var repsnumber: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        repsnumber.delegate = self 
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
