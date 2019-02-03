//
//  setsFreeExerciseTable.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢ صفر، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit

class setsFreeExerciseTable: UITableViewCell,  UITextFieldDelegate {

    @IBOutlet weak var setLabel: UILabel!
    
    @IBOutlet weak var repsLabel: UITextField!
    
    @IBOutlet weak var weightLabel: UITextField!
    @IBOutlet weak var rmaLabel: UILabel!
    @IBOutlet weak var volumeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        weightLabel.delegate = self
        repsLabel.delegate = self
              weightLabel.addTarget(self, action: #selector(textIsChanging), for: UIControlEvents.editingChanged)
            repsLabel.addTarget(self, action: #selector(textIsChanging), for: UIControlEvents.editingChanged)
    }
  
    @objc func textIsChanging(_ textField:UITextField) {
        if weightLabel.text != ""{
            let weight1 = weightLabel.text
            let weight:Int = Int(weight1!)!
            //            print("\(weight)")
            let reps1:Int = Int(repsLabel.text!)!
            let sets1:Int = Int(setLabel.text!)!
            let rm111:Double = 37 - Double(reps1)
            let rm11:Double = (Double(36/(rm111)))
            let rm1:Double = Double(weight) * rm11
            let r2 = Double(round(100*rm1)/100)
            let volume:Int = sets1 * reps1 * weight
            rmaLabel.text = "\(r2)"
            volumeLabel.text = "\(Int(volume))"
            
            
        }else{
            rmaLabel.text = "     "
            volumeLabel.text = "     "
        }
        print ("TextField is changing")
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        

        if textField == self.repsLabel{
            guard let text = repsLabel.text else { return true }
            if string.isEmpty { // This is for accept control characters
                return true
            }
            let numericRegEx = "[0-9]"
            let predicate = NSPredicate(format:"SELF MATCHES %@", numericRegEx)
            
            let newText = (repsLabel.text! as NSString).replacingCharacters(in: range, with: string)
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 2 && predicate.evaluate(with: string)
        }
        if textField == self.weightLabel{
            guard let text = weightLabel.text else { return true }
            if string.isEmpty { // This is for accept control characters
                return true
            }
            let numericRegEx = "[0-9]"
            let predicate = NSPredicate(format:"SELF MATCHES %@", numericRegEx)
            
            let newText = (weightLabel.text! as NSString).replacingCharacters(in: range, with: string)
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 3 && predicate.evaluate(with: string)
        }

        
        return true
    }

}
