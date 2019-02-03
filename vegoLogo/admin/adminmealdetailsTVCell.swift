//
//  adminmealdetailsTVCell.swift
//  vegoLogo
//
//  Created by Faris Alkhuzai on 11/11/1439 AH.
//  Copyright © 1439 Khaled Kutbi. All rights reserved.
//

import UIKit

class adminmealdetailsTVCell1: UITableViewCell,UITextFieldDelegate {


    @IBOutlet weak var mealQuintity: UITextField!
    
    @IBOutlet weak var mealType: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mealType.delegate = self
        mealQuintity.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


class adminmealdetailsTVCell2: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var elementType: UITextField!
    
    @IBOutlet weak var elementQuintity: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       elementType.delegate = self
        elementQuintity.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
