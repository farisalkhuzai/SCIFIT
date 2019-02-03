//
//  addNewFreeExerciseAdmin.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٨ صفر، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit

class addNewFreeExerciseAdmin: UIViewController , /*UIPickerViewDelegate, UIPickerViewDataSource ,*/ UITextFieldDelegate {
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        targtedMucleP.tag = 1
        nameOfExerciseP.tag = 2
        
//
//        targtedMucleP.delegate = self
//        targtedMucleP.dataSource = self
//        targtedMucle.delegate = self
//
//        nameOfExerciseP.delegate = self
//        nameOfExerciseP.dataSource = self
//        nameOfExercise.delegate = self
    }
    
    @IBOutlet weak var targtedMucle: UITextField!
    @IBOutlet weak var nameOfExercise: UITextField!
    @IBOutlet weak var exerciseImage: UIImageView!
    
    var targtedMucleP = UIPickerView()
    var nameOfExerciseP = UIPickerView()
    
    var selectedTargtedMucle : String = ""
    var selectednameOfMucle : String = ""
    
    @IBAction func addExeerciseButton(_ sender: Any) {
        
        
     
    
    }
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        <#code#>
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        <#code#>
//    }
//    
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if (pickerView.tag == 1){
//            selectedTargtedMucle = ExerciseElement.init(exername: <#T##String#>, image: <#T##String#>, sets: <#T##[Set]#>, targetedmuscle: <#T##String#>)
//            selectedTrainer = User.init(diet: users[row].diet, exercises: users[row].exercises, profile: users[row].profile)
//            trainerTf.text = selectedTrainer?.profile.userEmail
//            //            selectedTrainer = users[row]
//            //            trainerTf.text = selectedTrainer?.profile.name
//        }else {
//            selectedDays = dayArry[row]
//            dayTf.text = selectedDays
//        }
    }
    func designPieckerTextField(){
        //creat tool bar in picker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        // creat done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(daiteAdmin.donePressed))
        
        
        toolBar.setItems([doneButton], animated: true)
        
        
        // creat picker for every text field
        targtedMucle.inputView = targtedMucleP
        targtedMucle.inputAccessoryView = toolBar
        
        nameOfExercise.inputView = nameOfExerciseP
        nameOfExercise.inputAccessoryView = toolBar

        
        
        
    }
    @objc func donePressed(_ sender: UIBarButtonItem) {
        
        targtedMucle.resignFirstResponder()
        nameOfExercise.resignFirstResponder()
    }


}
