//
//  homePage.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٨ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
class homePage: UIViewController ,UITextFieldDelegate ,UITextViewDelegate{
    var ref:DatabaseReference!
    var currentweight:String!
   

    
 
 @IBOutlet weak var previousWeight: UITextField!
 @IBOutlet weak var currentWeight: UITextField!
 @IBOutlet weak var priefText: designTextView!
    //  @IBAction func closeMenu(_ sender: Any) {
//       self.menuView.isHidden = true
//
//    }
//    @IBAction func openMenu(_ sender: Any) {
//
//         self.menuView.isHidden = false
//
//        UIView.animate(withDuration: 0.3, animations: {
//            self.view.layoutIfNeeded()
//
//        }  )
//    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       priefText.isUserInteractionEnabled = false
        self.previousWeight.delegate = self
        self.currentWeight.delegate = self
        self.priefText.delegate = self
        loadWeightAndPreif()
//        self.menuView.layer.shadowOpacity = 1
//        self.menuView.layer.shadowRadius = 5
    }
    @IBAction func updateButton(_ sender: UIButton) {
        
        if currentWeight.text != currentweight{
        loadWeightAndPreif ()
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference().child("users").child(uid!)
//        loadWeightAndPreif()
        self.previousWeight.text = currentweight
        
        let catchCweight = currentWeight.text
        
        let updataWeight = ["previousWeight": currentweight,
                          "weight":catchCweight]
        ref.child("Profile").updateChildValues(updataWeight)
        }
        
    }
    func loadWeightAndPreif (){
        let uid = Auth.auth().currentUser?.uid
        self.previousWeight.text = currentweight
        
        
        ref = Database.database().reference().child("users").child(uid!)
        ref.child("Profile").observe(.value, with: { (snapshot ) in
            
            let value = snapshot.value as? NSDictionary
  
            let weight = value!["weight"] as? String ?? "0.0"
            let Pweight = value!["previousWeight"] as? String ?? "0.0"
            self.currentweight = weight
//             self.currentweight = self.currentWeight.text
            self.previousWeight.text = Pweight
//            self.previousWeight.text = self.currentweight
            self.currentWeight.text = weight
        
          //(load Preif)/////////
            let userPriefFromAdmin = value!["adminBrief"] as? String ?? ""
            self.priefText.text = userPriefFromAdmin
            
            
        })
        
        
      
        
        
        
    }
        
        
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = currentWeight.text else { return true }
        if string.isEmpty { // This is for accept control characters
            return true
        }
        let numericRegEx = "[0-9]"
        let predicate = NSPredicate(format:"SELF MATCHES %@", numericRegEx)
        
        let newText = (currentWeight.text as! NSString).replacingCharacters(in: range, with: string)
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 3 && predicate.evaluate(with: string)// replace 30 for your max length value
    }
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }
    

  

}
