//
//  personalInfoViewController.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢١ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase

class personalInfoViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource , UITextFieldDelegate{
    //////(text Feild)//////////
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTExtField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var activityLevelTextField: UITextField!
    @IBOutlet weak var goalTextField: UITextField!
    
    /////(labels)///////////
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var weghit: UILabel!
    @IBOutlet weak var hieght: UILabel!
    @IBOutlet weak var activityLevel: UILabel!
    @IBOutlet weak var trainingGoal: UILabel!
  
    
    var ref:DatabaseReference!
    var checkIfIsAdmin : String!
    
    
    
    var activityLevePickerView = UIPickerView()
    var trainingGoalPickerView = UIPickerView()
    
    var selectedActivityLevel:String?
    var selectedTrainingGoal:String?
    
    let activityLevelArray = ["مستوى النشاط","منخفض","عالي"]
    let trainingGoalArray = ["الهدف الرياضي","زيادة عضل","زيادة وزن","تخفيف وزن","محافظة"]
    
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
        activityLevelTextField.text = selectedActivityLevel
        }else{
            print(trainingGoalArray[row])
            selectedTrainingGoal = trainingGoalArray[row]
            goalTextField.text = selectedTrainingGoal
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
        activityLevelTextField.inputView = activityLevePickerView
        activityLevelTextField.inputAccessoryView = toolBar
        
        goalTextField.inputView = trainingGoalPickerView
        goalTextField.inputAccessoryView = toolBar
        
        
    }

    
   
    @objc func donePressed(_ sender: UIBarButtonItem) {
        
        activityLevelTextField.resignFirstResponder()
        goalTextField.resignFirstResponder()
        
        
    }
    
    func loadInfo () {
        
            let uid = Auth.auth().currentUser?.uid
        
        ref = Database.database().reference().child("users").child(uid!)
        ref.child("Profile").observe(.value, with: { (snapshot ) in
          
            let value = snapshot.value as? NSDictionary
            let age = value!["age"] as! String
            let height = value!["height"] as! String
            let name = value!["name"] as! String
            let userActivity = value!["userActivity"] as! String
            let userGoal = value!["userGoal"] as! String
            let weight = value!["weight"] as! String
            let email = value!["userEmail"] as! String
            
            self.nameTextField.text = name
            self.ageTextField.text = age
            self.weightTExtField.text = weight
            self.heightTextField.text = height
            self.activityLevelTextField.text = userActivity
            self.goalTextField.text = userGoal
            
            
          
            
        })




    }
 
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func updateButton(_ sender: Any) {
        if ageTextField.text != "" && heightTextField.text != "" && nameTextField.text != "" && selectedActivityLevel != "" && selectedTrainingGoal != "" && weightTExtField.text != "" {
            addProfile()
            
        
            
        }else{
            self.showALert(titel: "تحذير !", message: "لم تدخل كامل البيانات ")
        
        }
        
       
    }
    func showALert(titel : String , message: String){
        let alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

    func addProfile(){
        //        let userID = Auth.auth().currentUser?.uid
        
        
        let userID = Auth.auth().currentUser!.uid
        
        
        let userid = String(userID)
        let ageText = ageTextField.text
        let heightText = heightTextField.text
        let nameText = nameTextField.text
        let weightText = weightTExtField.text
        let activityText = activityLevelTextField.text
        let goaltext = goalTextField.text
        ref = Database.database().reference().child("users").child(userID)
        let profilechild = ["age": ageText ,
                            "height": heightText ,
                            "name": nameText,
                            "userActivity": activityText ,
                            "userGoal": goaltext,
                            "weight": weightText ,
                            "uid": userid
            
        ]
        Logger.normal(tag: "uid", message: userID)
        // ref.child("users").child("\(userID)").child("Profile").setValue(profilechild)
        self.ref.child("Profile").updateChildValues(profilechild as Any as! [AnyHashable : Any]) { (error, ref) in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
        }
        
        
    }

//
//    @IBAction func saveName(_ sender: Any) {
//        let uid = Auth.auth().currentUser?.uid
//        ref = Database.database().reference().child("users").child(uid!)
//        let catchName = nameTextField.text
//        let updataName = ["name": catchName ]
//        ref.child("Profile").updateChildValues(updataName)
//
//    }
//
//
//    @IBAction func saveAge(_ sender: Any) {
//        let uid = Auth.auth().currentUser?.uid
//        ref = Database.database().reference().child("users").child(uid!)
//        let catchAge = ageTextField.text
//        let updatAge = ["age": catchAge ]
//        ref.child("Profile").updateChildValues(updatAge)
//
//
//    }
//
//
//    @IBAction func saveWeight(_ sender: Any) {
//        let uid = Auth.auth().currentUser?.uid
//        ref = Database.database().reference().child("users").child(uid!)
//        let catchWeight = weightTExtField.text
//        let updataWeight = ["weight": catchWeight ]
//        ref.child("Profile").updateChildValues(updataWeight)
//
//
//    }
//
//    @IBAction func saveHeight(_ sender: Any) {
//        let uid = Auth.auth().currentUser?.uid
//        ref = Database.database().reference().child("users").child(uid!)
//        let catchHeight = heightTextField.text
//        let updataHeight = ["height": catchHeight ]
//        ref.child("Profile").updateChildValues(updataHeight)
//
//
//    }
//
//
//    @IBAction func saveActivityLavel(_ sender: Any) {
//        let uid = Auth.auth().currentUser?.uid
//        ref = Database.database().reference().child("users").child(uid!)
//        let catchActivityLavel = activityLevelTextField.text
//        let updataActivityLavel = ["userActivity": catchActivityLavel ]
//        ref.child("Profile").updateChildValues(updataActivityLavel)
//
//
//    }
//
//
//    @IBAction func saveGoal(_ sender: Any) {
//        let uid = Auth.auth().currentUser?.uid
//        ref = Database.database().reference().child("users").child(uid!)
//        let catchGoal = goalTextField.text
//        let updataGoal = ["userGoal": catchGoal ]
//        ref.child("Profile").updateChildValues(updataGoal)
//
//
//    }
//
//    @IBAction func saveEmail(_ sender: Any) {
//        let uid = Auth.auth().currentUser?.uid
//        ref = Database.database().reference().child("users").child(uid!)
//        let catchEmail = emailTextField.text
//        let updataEmail = ["userEmail": catchEmail ]
//        ref.child("Profile").updateChildValues(updataEmail)
//
//    }
//
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadInfo()
        activityLevePickerView.tag = 1
        trainingGoalPickerView.tag = 2
        
        
        activityLevePickerView.delegate = self
        activityLevePickerView.dataSource = self
        activityLevelTextField.delegate = self
        
        trainingGoalPickerView.delegate = self
        trainingGoalPickerView.dataSource = self
        goalTextField.delegate = self
      
        designPieckerTextField()
        
        
        nameTextField.delegate = self
        ageTextField.delegate = self
        weightTExtField.delegate = self
        heightTextField.delegate = self
        
        
        changNameLabelIfIsAdmin()
    }
    
    func changNameLabelIfIsAdmin(){
        let uid = Auth.auth().currentUser?.uid
        ref = Database.database().reference().child("users").child(uid!)
        ref.child("Profile").observe(.value, with: { (snapshot ) in
            
            let value = snapshot.value as? NSDictionary
            let ifIsAdmin = value!["isAdmin"] as! String
            self.checkIfIsAdmin = ifIsAdmin
            
            if (self.checkIfIsAdmin == "true"){
                self.name.text = "اسم المدرب:"
                self.age.text = "عمر المدرب:"
                self.weghit.text = "وزن المدرب:"
                self.hieght.text = "طول المدرب:"
                
            }else {
                return
            }
            
        })
        
    }

    @IBAction func onBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if textField == self.heightTextField{
            guard let text = heightTextField.text else { return true }
            if string.isEmpty { // This is for accept control characters
                return true
            }
            let numericRegEx = "[0-9]"
            let predicate = NSPredicate(format:"SELF MATCHES %@", numericRegEx)
            
            let newText = (heightTextField.text! as NSString).replacingCharacters(in: range, with: string)
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 3 && predicate.evaluate(with: string)
        }
        if textField == self.weightTExtField{
            guard let text = weightTExtField.text else { return true }
            if string.isEmpty { // This is for accept control characters
                return true
            }
            let numericRegEx = "[0-9]"
            let predicate = NSPredicate(format:"SELF MATCHES %@", numericRegEx)
            
            let newText = (weightTExtField.text! as NSString).replacingCharacters(in: range, with: string)
            let newLength = text.characters.count + string.characters.count - range.length
            return newLength <= 3 && predicate.evaluate(with: string)
        }
        
        return true
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
