//
//  addExUserAdmin.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٩ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
class addExUserAdmin: UIViewController ,UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate ,UITextViewDelegate , UITableViewDelegate, UITableViewDataSource {
    var ref: DatabaseReference!
    
    @IBOutlet weak var trainerTf: UITextField!
    @IBOutlet weak var monthTf: UITextField!
    @IBOutlet weak var weekTf: UITextField!
    @IBOutlet weak var dayTf: UITextField!
    @IBOutlet weak var exersiceCountTf: UITextField!
    @IBOutlet weak var targetMuscleTf: UITextField!
    @IBOutlet weak var typeOfExTf: UITextField!
    
    var trainerPickerView = UIPickerView()
    var dayPickerView = UIPickerView()
    var monthPickerView = UIPickerView()
    var weekPickerView = UIPickerView()
    var exersiceCountPickerView = UIPickerView()
    var targetMusclePickerView = UIPickerView()
    var typeOfExPickerView = UIPickerView()
    
    @IBOutlet weak var setsTV: UITableView!
    @IBOutlet weak var exerciseimg: UIImageView!
    
    var selectedTrainer : User?
    var selectedMonth : String?
    var selectedWeek : String?
    var selectedDays : String?
    var selectedexersiceCount : String?
    var selectedtargetMuscle : String?
    var selectedtypeOfEx : ExerciesValue?
    var exercount: Int?
    var users = [User]()
    var exercise = [ExerciesValue]()
    var exercises: ExerciesValue!
    var sets = [Set]()
    var execount: String?
    var exer1:ExerciseWeeks?
    var exer2:ExerciseElement?
    //    var trainerArray = ["ali","asad","sami","fares"]
    var dayArry = ["day1","day2","day3","day4","day5","day6","day7"]
    
    var weekArray = ["week1","week2","week3","week4"]
    var monthArray = ["month1","month2","month3","month4"]
    var week: String?
    var exersiceCountArray = ["1","2","3","4","5","6","7","8","9","10"]
    var targetMuscleArray  = ["صدر","كور","ظهر","ترابيس","باي","تراي","رجول","بطات"]
//    var typeOfExersiceArray = ["kjh;lk","sdf","dfg"]
    
    
    //    func loadPicture(){
    //        do{
    //
    //            let imgURL = exercise.image
    //            let url = URL(string: imgURL)
    ////            let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/vego-6.appspot.com/o/exercises%2F2?alt=media&token=b90ad507-4a4c-447a-97d4-6ea05e2265d8")
    //            let data = try Data(contentsOf: url!)
    ////            let gif = UIImage.gifI
    //            self.exerciseimg.image = UIImage(data: data)
    //        }
    //        catch{
    //            print(error)
    //        }
    //
    //
    //
    //
    //    }
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
    func getexerice(){
        ref.child("exercies").observe(.value, with: { (snapshot) in
            
            do {
                // Get user value
                
                for snap in snapshot.children {
                    let userSnap = snap as! DataSnapshot
                    let jsonData = try JSONSerialization.data(withJSONObject: userSnap.value)
                    self.exercise.append(try! JSONDecoder().decode(ExerciesValue.self, from: jsonData))
                }
                
                self.typeOfExPickerView.reloadAllComponents()
                //print(value)
            } catch let error {
                print(error)
            }
            
            // guard let value = snapshot.value as? [String: Any] else { return }
            // ...
        }){ (error) in
            print(error.localizedDescription)
        }
//        ref.child("exercies").observeSingleEvent(of: .value, with: { (snapshot) in
//
//            do {
//                // Get user value
//
//                for snap in snapshot.children {
//                    let userSnap = snap as! DataSnapshot
//                    let jsonData = try JSONSerialization.data(withJSONObject: userSnap.value)
//                    self.exercise.append(try! JSONDecoder().decode(ExerciesValue.self, from: jsonData))
//                }
//
//                self.typeOfExPickerView.reloadAllComponents()
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
    func getexericecount(){
        
        

       let exercountRef = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Exercises").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!)
    self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Exercises").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!).child("exercise").observe( .value, with:{ snapshot in
    

    self.execount = String(Int(snapshot.childrenCount))
        self.exercount = Int(snapshot.childrenCount)

        let dayexecount = ["exercisecount": self.execount!] as [String : Any]
        exercountRef.updateChildValues(dayexecount as [AnyHashable : Any])

        }){ (error) in
            print(error.localizedDescription)
        }

    }
    @IBAction func addExerciseButton(_ sender: UIButton) {

        if trainerTf.text != "" && monthTf.text != "" && weekTf.text != "" && dayTf.text != "" && exersiceCountTf.text != "" && targetMuscleTf.text != "" && typeOfExTf.text != "" && sets.isEmpty == false{
            
            append()
            self.showALert(titel: "", message: "تم حفظ التمرين")
        }else{
            self.showALert(titel: "تحذير !", message: "لم تدخل كامل بيانات الوجبة")
        }
//        getexericecount()
    }
   
    
    @IBAction func addSetButton(_ sender: Any) {
//        getexericecount()
        sets.reserveCapacity(3)
        if (sets.count) < 3 {
        sets.append(Set(reps: "0", rm1: "", volume: "", weight: ""))
        }
        setsTV.reloadData()
    }
    @IBAction func deleteset(_ sender: UIButton) {
        if sets.isEmpty == false{
        sets.removeLast()
        }
        setsTV.reloadData()
    }
    func append(){
        ref = Database.database().reference()
        
        for i in 0..<sets.count  {
            let indexpath = IndexPath(row: i, section: 0)
            let cell = setsTV.cellForRow(at: indexpath)! as! setsCell
            sets[i].reps = cell.repsnumber.text!

        }
        //            exer2 = [ExerciseElement.init(exername: (selectedtypeOfEx?.exername)!, image: selectedtypeOfEx?.image ?? <#default value#>, sets: sets, targetedmuscle: selectedtargetMuscle!)]
        //            exer1 = Exercise.init(day: selectedDays!, exercise: exer2, exercisecount: selectedexersiceCount!, targetedmuscles: selectedtargetMuscle!)
        //            sets = [Set.init(reps: sets[i].reps, rm1: "", volume: "", weight: "")]
                    exer2 = ExerciseElement.init(exername: (selectedtypeOfEx?.exername)!, image: (selectedtypeOfEx?.image)!, sets: sets, targetedmuscle: selectedtargetMuscle!)
//        exer1 = ExerciseWeeks.init(day: selectedDays!, exercise: exer2, exercisecount: self.execount, targetedmuscles: selectedtargetMuscle!)
                            ref.child("users").observe(.value, with: { snapshot in
            //                print(snapshot.childrenCount)
            //            let i = snapshot.childrenCount
            let userRef = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Exercises").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!).child("exercise").child(self.selectedexersiceCount!)

            let data = try! FirebaseEncoder().encode(self.exer2)
                                userRef.updateChildValues(data as! [AnyHashable : Any])

        })

        
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sets.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! setsCell
        cell.setsnumber.text = "\(indexPath.row + 1)"
        cell.repsnumber.text = "\(sets[indexPath.row].reps)"
        
        return cell
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return users[row].profile.userEmail
        }else if (pickerView.tag == 2){
            return dayArry[row]
        }else if (pickerView.tag == 3){
            return exersiceCountArray[row]
        }else if (pickerView.tag == 4){
            return targetMuscleArray[row]
        }else if (pickerView.tag == 6){
            return monthArray[row]
        }else if (pickerView.tag == 7){
            return weekArray[row]
        }else{
            return exercise[row].exername
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return (users.count)
        }else if (pickerView.tag == 2){
            return dayArry.count
        }else if (pickerView.tag == 3){
            
            let ecount = exercount! + 1
            return ecount
//            return exersiceCountArray.count
        }else if (pickerView.tag == 4){
            return targetMuscleArray.count
        }else if(pickerView.tag == 6){
            return monthArray.count
        }else if (pickerView.tag == 7){
         
            return weekArray.count
        }else {
            return exercise.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(pickerView.tag)
        if (pickerView.tag == 1){
            selectedTrainer = User.init(diet: users[row].diet, exercises: users[row].exercises, profile: users[row].profile)
            trainerTf.text = selectedTrainer?.profile.userEmail
            //            selectedTrainer = users[row]
            //            trainerTf.text = selectedTrainer?.profile.name
        }else if (pickerView.tag == 2){
            selectedDays = "\(row)"
            let days = dayArry[row]
            dayTf.text = days
            getexericecount()
        }else if (pickerView.tag == 3){
            selectedexersiceCount = "\(row)"
//            selectedexersiceCount = exersiceCountArray[row]
            let exers = exersiceCountArray[row]
            exersiceCountTf.text = exers
        }else if (pickerView.tag == 4){
            selectedtargetMuscle = targetMuscleArray[row]
            targetMuscleTf.text = selectedtargetMuscle
        }else if(pickerView.tag == 6){
            selectedMonth = "\(row)"
           let Months = monthArray[row]
            monthTf.text = Months
        }else if(pickerView.tag == 7){
            
            selectedWeek = weekArray[row]
            if selectedWeek == "week1" {
            week = selectedWeek
            }
            if selectedWeek == "week2" {
                week = selectedWeek
            }
            if selectedWeek == "week3" {
                week = selectedWeek
            }
            if selectedWeek == "week4" {
                week = selectedWeek
            }
            weekTf.text = selectedWeek
            
        } else {
        
            selectedtypeOfEx = ExerciesValue.init(exername: exercise[row].exername, image: exercise[row].image, targetedmuscle: exercise[row].targetedmuscle)
            
            typeOfExTf.text = selectedtypeOfEx?.exername
            DispatchQueue.global().async {
            do{
                
                let imgURL = self.exercise[row].image
                let url = URL(string: imgURL)
                //            let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/vego-6.appspot.com/o/exercises%2F2?alt=media&token=b90ad507-4a4c-447a-97d4-6ea05e2265d8")
                let data = try Data(contentsOf: url!)
                //            let gif = UIImage.gifI
                DispatchQueue.main.async {
                self.exerciseimg.image = UIImage.gif(data: data)
                }
            }
            catch{
                print(error)
            }
        }
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
        trainerTf.inputView = trainerPickerView
        trainerTf.inputAccessoryView = toolBar
        
        monthTf.inputView = monthPickerView
        monthTf.inputAccessoryView = toolBar
        
        weekTf.inputView = weekPickerView
        weekTf.inputAccessoryView = toolBar
        
        dayTf.inputView = dayPickerView
        dayTf.inputAccessoryView = toolBar
        
        exersiceCountTf.inputView = exersiceCountPickerView
        exersiceCountTf.inputAccessoryView = toolBar
        
        targetMuscleTf.inputView = targetMusclePickerView
        targetMuscleTf.inputAccessoryView = toolBar
        
        typeOfExTf.inputView = typeOfExPickerView
        typeOfExTf.inputAccessoryView = toolBar
        
        
        
        
        
    }
    @objc func donePressed(_ sender: UIBarButtonItem) {
        
        trainerTf.resignFirstResponder()
        exersiceCountTf.resignFirstResponder()
        monthTf.resignFirstResponder()
        weekTf.resignFirstResponder()
        dayTf.resignFirstResponder()
        targetMuscleTf.resignFirstResponder()
        typeOfExTf.resignFirstResponder()
        
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if (textField == self.dayTf || textField == self.exersiceCountTf){
//            if (self.trainerTf.text != "" && self.monthTf.text != "" && self.weekTf.text != "" ){
//                self.dayTf.isEnabled = true
//                self.exersiceCountTf.isEnabled = true
//                print("sss")
//            }else {
//                
//                self.dayTf.isEnabled = false
//                self.exersiceCountTf.isEnabled = false
//                self.showALert(titel: "", message: "لابد ان تحدد اسم المستخدم والشهر والاسبوع")
//            }
//        }
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
        setsTV.delegate = self
        trainerPickerView.tag = 1
        dayPickerView.tag = 2
        exersiceCountPickerView.tag = 3
        targetMusclePickerView.tag = 4
        typeOfExPickerView.tag = 5
        monthPickerView.tag = 6
        weekPickerView.tag = 7
        
        trainerPickerView.delegate = self
        trainerPickerView.dataSource = self
        trainerTf.delegate = self
        
        monthPickerView.delegate = self
        monthPickerView.dataSource = self
        monthTf.delegate = self
        
        weekPickerView.delegate = self
        weekPickerView.dataSource = self
        weekTf.delegate = self
        
        dayPickerView.delegate = self
        dayPickerView.dataSource = self
        dayTf.delegate = self
        
        exersiceCountPickerView.delegate = self
        exersiceCountPickerView.dataSource = self
        exersiceCountTf.delegate = self
        
        targetMusclePickerView.delegate = self
        targetMusclePickerView.dataSource = self
        targetMuscleTf.delegate = self
        
        typeOfExPickerView.delegate = self
        typeOfExPickerView.dataSource = self
        typeOfExTf.delegate = self
        
        designPieckerTextField()
        
        //        loadPicture()
//getexericecount()
        getTrainer()
        getexerice()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
}
}
