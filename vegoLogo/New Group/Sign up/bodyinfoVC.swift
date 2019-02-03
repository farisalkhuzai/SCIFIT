//
//  bodyinfoVC.swift
//  vegoLogo
//
//  Created by Faris Alkhuzai on 03/11/1439 AH.
//  Copyright © 1439 Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class bodyinfoVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate , UITextFieldDelegate {
    var ref:DatabaseReference!
  
    //components
    @IBOutlet weak var textLableW: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var ageView: UIView!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var weightView: UIView!
    @IBOutlet weak var highetTextField: UITextField!
    @IBOutlet weak var highetView: UIView!
    @IBOutlet weak var activityLeveTextField: UITextField!
    @IBOutlet weak var trainingGoalTextField: UITextField!
    
   
    // put picker insid text Field
    var activityLevePickerView = UIPickerView()
    var trainingGoalPickerView = UIPickerView()
    
    // Selected from picker
    
    var selectedActivityLevel:String?
    var selectedTrainingGoal:String?
    
    // array of picker
    let activityLevelArray = ["عالي","متوسط","منخفض"]
    let trainingGoalArray = ["بناء عضلات","زيادة الوزن","انقاص وزن","خسارة الدهون والمحافظة "]
    
    var googleID:String?
   
    
    
    @IBAction func save(_ sender: UIButton) {
      
        infocheck()
        addProfile()
       
        
        
//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            let allowedChracters = CharacterSet.letters
//            let characterSet = CharacterSet(charactersIn: string)
//            
//            return allowedChracters.isSuperset(of: characterSet)
//        }
        
        print("الوزن: \(String(describing: weightTextField.text))")
        print("الطول: \(String(describing: highetTextField.text))")
        print("العمر: \(String(describing: ageTextField.text))")


    }
    
    // related to pickers
    
    
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return activityLevelArray.count
        }else {
            return trainingGoalArray.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return  "\(activityLevelArray[row])"
        } else {
            return  "\(trainingGoalArray[row])"
        }
    }
   
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1{
            print(activityLevelArray[row])
           selectedActivityLevel = activityLevelArray[row]
            activityLeveTextField.text = selectedActivityLevel
        }else{
            print(trainingGoalArray[row])
            selectedTrainingGoal = trainingGoalArray[row]
            trainingGoalTextField.text = selectedTrainingGoal
        }

        }


    func addProfile(){
        //        let userID = Auth.auth().currentUser?.uid
    

           let userID = Auth.auth().currentUser!.uid

        
        let userid = String(userID)
        let ageText = ageTextField.text
        let heightText = highetTextField.text
        let nameText = nameTextField.text
        let weightText = weightTextField.text
        ref = Database.database().reference().child("users").child(userID)
        let profilechild = ["age": ageText ,
                            "height": heightText ,
                            "name": nameText,
                            "userActivity": selectedActivityLevel ,
                            "userGoal": selectedTrainingGoal ,
                            "weight": weightText ,
                            "uid": userid
            
        ]
        Logger.normal(tag: "uid", message: userID)
        // ref.child("users").child("\(userID)").child("Profile").setValue(profilechild)
        self.ref.child("Profile").updateChildValues(profilechild as Any as! [AnyHashable : Any]) { (error, ref) in
            if error != nil{
                print(error?.localizedDescription)
                return
            }else{
                print("Edit successful")
                self.infocheck()
            }
        }
        
      
    }
    func infocheck(){
        let userID = Auth.auth().currentUser!.uid
        ref = Database.database().reference().child("users").child(userID)
        ref.child("Profile").observe(.value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let age = value!["age"] as! String
            let height = value!["height"] as! String
            let name = value!["name"] as! String
            let userActivity = value!["userActivity"] as! String
            let userGoal = value!["userGoal"] as! String
            let weight = value!["weight"] as! String
                        if age != "" && height != "" && name != "" && userActivity != "" && userGoal != "" && weight != ""{
            
//            if age != ""{
                print("details exist")
                self.performSegue(withIdentifier: "fullsignup", sender: nil)
            }else{
                //                    self.performSegue(withIdentifier: "infocheck", sender: nil)
                self.ageTextField.text = age
                self.highetTextField.text = height
                self.nameTextField.text = name
                self.selectedActivityLevel = userActivity
                self.selectedTrainingGoal = userGoal
                self.weightTextField.text = weight
                
                
                
            }
        
            
            // ...
        }){ (error) in
            print(error.localizedDescription)
            
        }

    }
    func designPieckerTextField(){
        //creat tool bar in picker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        // creat done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(daiteAdmin.donePressed))
        
        
        toolBar.setItems([doneButton], animated: true)
      
        
        // creat picker for every text field
        activityLeveTextField.inputView = activityLevePickerView
        activityLeveTextField.inputAccessoryView = toolBar
        
        trainingGoalTextField.inputView = trainingGoalPickerView
        trainingGoalTextField.inputAccessoryView = toolBar
        
        
    }
    @objc func donePressed(_ sender: UIBarButtonItem) {
        
        activityLeveTextField.resignFirstResponder()
        trainingGoalTextField.resignFirstResponder()
        
    
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
    func showALert(titel : String , message: String){
        let alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if CheckInternet.Connection() {
            
            print("internet is connected ")
            
        }else {
            self.showALert(titel: "تنبيه ! ", message: "الاتصال بالنترنت ضعيف او مقطوع ")
            print("internet is not connected ")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         self.textLableW.font = UIFont(name: "TheSans", size: 17)

        nameTextField.delegate = self
        ageTextField.delegate = self
        weightTextField.delegate = self
        

        activityLevePickerView.tag = 1
        trainingGoalPickerView.tag = 2
      
        
        activityLevePickerView.delegate = self
        activityLevePickerView.dataSource = self
        activityLeveTextField.delegate = self
        
        trainingGoalPickerView.delegate = self
        trainingGoalPickerView.dataSource = self
        trainingGoalTextField.delegate = self
        
        nameTextField.delegate = self
        ageTextField.delegate = self
        highetTextField.delegate = self
        weightTextField.delegate = self
        
        
         designPieckerTextField()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == self.nameTextField {
            guard NSCharacterSet(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz أ ا ب ت ج ح خ د ذ ر ز س ش ص ض ط ظ ع غ ف ق ك ل م ن ه و ي ى ة ء ئ إ").isSuperset(of: CharacterSet(charactersIn: string)) else {
                return false
            }
        }
        if textField == self.ageTextField{
            guard let text = ageTextField.text else { return true }
            if string.isEmpty { // This is for accept control characters
                return true
            }
            let numericRegEx = "[0-9]"
            let predicate = NSPredicate(format:"SELF MATCHES %@", numericRegEx)
            
            let newText = (ageTextField.text! as NSString).replacingCharacters(in: range, with: string)
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 2 && predicate.evaluate(with: string)
        }
        if textField == self.highetTextField{
            guard let text = highetTextField.text else { return true }
            if string.isEmpty { // This is for accept control characters
                return true
            }
            let numericRegEx = "[0-9]"
            let predicate = NSPredicate(format:"SELF MATCHES %@", numericRegEx)
            
            let newText = (highetTextField.text! as NSString).replacingCharacters(in: range, with: string)
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 3 && predicate.evaluate(with: string)
        }
        if textField == self.weightTextField{
            guard let text = weightTextField.text else { return true }
            if string.isEmpty { // This is for accept control characters
                return true
            }
            let numericRegEx = "[0-9]"
            let predicate = NSPredicate(format:"SELF MATCHES %@", numericRegEx)
            
            let newText = (weightTextField.text! as NSString).replacingCharacters(in: range, with: string)
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 3 && predicate.evaluate(with: string)
        }
        
        return true
    }


}
