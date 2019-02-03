//
//  adminProgress.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٥ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase

extension UIViewController
{
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

class adminProgress: UIViewController ,UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate ,UITextViewDelegate {
    
     var ref: DatabaseReference!
    let  defaoltPriefText :String = ""
    
    // component
    
    @IBOutlet weak var trainerTf: UITextField!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var currentWeghitLable: UILabel!
    @IBOutlet weak var heightLable: UILabel!
    @IBOutlet weak var ageLable: UILabel!
    @IBOutlet weak var perfictWeghit: UITextField!
    @IBOutlet weak var userGoalLable: UILabel!
    @IBOutlet weak var activityLevelLable: UILabel!
    @IBOutlet weak var preefTextView: UITextView!
    
   //////////////// // login as admin or normal user or trainer
    @IBOutlet weak var adminSwitch: UISwitch!
    @IBOutlet weak var ifAdmin: UILabel!

    
    @IBAction func setAdmin(_ sender: UISwitch) {
        //        let uid = Auth.auth().currentUser?.uid
        let uid = selectedTrainer?.profile.uid
        ref = Database.database().reference().child("users").child(uid!)
        if (sender.isOn == true){
            //            let uid = Auth.auth().currentUser?.uid
            //            ref = Database.database().reference().child("users").child(uid!)
            let updataAdmin = ["isAdmin": "true" ]
            ref.child("Profile").updateChildValues(updataAdmin)
            ifAdmin.text = "مدرب"
        } else {
            let updataAdmin = ["isAdmin": "false" ]
            ref.child("Profile").updateChildValues(updataAdmin)
            ifAdmin.text = "متدرب"
        }
    }
    
    @IBAction func addPreef(_ sender: Any) {
        if (preefTextView.text != "" && trainerTf.text != "") {
    
        let uid = selectedTrainer?.profile.uid
        let adminPreef = preefTextView.text
        
        ref = Database.database().reference().child("users").child(uid!).child("Profile")
        let updateAdminPreef = ["adminBrief" : self.preefTextView.text ]
        ref.updateChildValues(updateAdminPreef)
        
        ///(add pupup)///////////////////////
             self.showALert(titel: "", message: "تم اضافة النصيحة ")
        self.preefTextView.text = defaoltPriefText
            
        } else {
            print("no preef added")
            self.showALert(titel: "", message: "لم تدخل ايميل المتدرب ")
        }
    }
    func showALert(titel : String , message: String){
        let alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    // declearation  as picker view
    var trainerPickerView = UIPickerView()
    
    
    // array from database
    var users = [User]()

    // selected from picker
       var selectedTrainer : User?
    

    // fuction related to pickerview
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return users[row].profile.userEmail
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         selectedTrainer = User.init(diet: users[row].diet, exercises: users[row].exercises, profile: users[row].profile)
        trainerTf.text = selectedTrainer?.profile.userEmail
        updateUI()
        
    }

    func getTrainer(){
        ref.child("users").observe(.value, with: { (snapshot) in
            
            do {
                // Get user value
                
                for snap in snapshot.children {
                    let userSnap = snap as! DataSnapshot
                    let uid = userSnap.key //the uid of each user
                    let jsonData = try JSONSerialization.data(withJSONObject: userSnap.value)
                    self.users.append(try! JSONDecoder().decode(User.self, from: jsonData))
                }
                self.trainerPickerView.reloadAllComponents()
                //print(value)
            } catch let error {
                print(error)
            }
            
            // guard let value = snapshot.value as? [String: Any] else { return }
            // ...
        }){ (error) in
            print(error.localizedDescription)
        }
//        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
//            
//            do {
//                // Get user value
//                
//                for snap in snapshot.children {
//                    let userSnap = snap as! DataSnapshot
//                    let uid = userSnap.key //the uid of each user
//                    let jsonData = try JSONSerialization.data(withJSONObject: userSnap.value)
//                    self.users.append(try! JSONDecoder().decode(User.self, from: jsonData))
//                }
//                self.trainerPickerView.reloadAllComponents()
//                //print(value)
//            } catch let error {
//                print(error)
//            }
//            
//            // guard let value = snapshot.value as? [String: Any] else { return }
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
    }

    
    func designPieckerTextField(){
        //creat tool bar in picker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        // creat done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(adminProgress.donePressed))
        
        
        toolBar.setItems([doneButton], animated: true)
        
        
        // creat picker for every text field
        trainerTf.inputView = trainerPickerView
        trainerTf.inputAccessoryView = toolBar
    }
    
    @objc func donePressed(_ sender: UIBarButtonItem) {
        trainerTf.resignFirstResponder()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        perfictWeghit.delegate = self
        preefTextView.delegate = self
        self.ref = Database.database().reference()
        
        trainerPickerView.tag = 1
        
        trainerPickerView.delegate = self
        trainerPickerView.dataSource = self
        trainerTf.delegate = self
        
        designPieckerTextField()
        getTrainer()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(){
        self.nameLable.text = self.selectedTrainer?.profile.name
        self.currentWeghitLable.text = self.selectedTrainer?.profile.weight
        self.heightLable.text = self.selectedTrainer?.profile.height
        self.ageLable.text = self.self.selectedTrainer?.profile.age
        self.userGoalLable.text = self.selectedTrainer?.profile.userGoal
        self.activityLevelLable.text = self.self.selectedTrainer?.profile.userActivity
        
    }
    



}
