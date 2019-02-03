//
//  trainingSetCell.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢٠ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit

class trainingSetCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var setnumber: UILabel!
    @IBOutlet weak var repsnumber: UILabel!
    @IBOutlet weak var weightuser: UITextField!
    @IBOutlet weak var rm1calc: UILabel!
    @IBOutlet weak var volumecalc: UILabel!
  
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        weightuser.delegate = self
            weightuser.addTarget(self, action: #selector(textIsChanging), for: UIControlEvents.editingChanged)
        }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
        
        @objc func textIsChanging(_ textField:UITextField) {
            if weightuser.text != ""{
                let weight1 = weightuser.text
                let weight:Int = Int(weight1!)!
                //            print("\(weight)")
                let reps1:Int = Int(repsnumber.text!)!
                let sets1:Int = Int(setnumber.text!)!
                let rm111:Double = 37 - Double(reps1)
                let rm11:Double = (Double(36/(rm111)))
                let rm1:Double = Double(weight) * rm11
                let r2 = Double(round(100*rm1)/100)
                let volume:Int = sets1 * reps1 * weight
                rm1calc.text = "\(r2)"
                volumecalc.text = "\(Int(volume))"
                
                
            }else{
                rm1calc.text = "     "
                volumecalc.text = "     "
            }
            print ("TextField is changing")
            
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            //        if weightuser.text != ""{
            //            let weight1 = weightuser.text
            //            let weight:Int = Int(weight1!)!
            //            //            print("\(weight)")
            //            let reps1:Int = Int(repsnumber.text!)!
            //            let sets1:Int = Int(setnumber.text!)!
            //            let rm111:Double = 37 - Double(reps1)
            //            let rm11:Double = (Double(36/(rm111)))
            //            let rm1:Double = Double(weight) * rm11
            //            let volume:Int = sets1 * reps1 * weight
            //            rm1calc.text = "\(rm1)"
            //            volumecalc.text = "\(Int(volume))"
            //
            //        }else{
            //            rm1calc.text = "     "
            //            volumecalc.text = "     "
            //        }
            // Configure the view for the selected state
}
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = weightuser.text else { return true }
        if string.isEmpty { // This is for accept control characters
            return true
        }
        let numericRegEx = "[0-9]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", numericRegEx)
        
        let newText = (weightuser.text as! NSString).replacingCharacters(in: range, with: string)
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 3 && predicate.evaluate(with: string)// replace 30 for your max length value
    }

}
