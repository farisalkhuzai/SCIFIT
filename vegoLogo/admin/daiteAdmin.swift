//
//  daiteAdmin.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٠ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class daiteAdmin: UIViewController ,UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate ,UITextViewDelegate {
    
    var ref: DatabaseReference!
    // وضع اسم الموديول داخل متغير لسهولة الوصول الي المتغيرات التي بداخل الموديول
    
    
    // link component with controller
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var trainerPickerTf: UITextField!
    
    @IBOutlet weak var monthTf: UITextField!
    
    @IBOutlet weak var weekTf: UITextField!
    
    @IBOutlet weak var daysPickerTf: UITextField!
    @IBOutlet weak var countOfMealTf: UITextField!
    @IBOutlet weak var mealPickerTf: UITextField!
   
    
    // declearation  as picker view
    var trainerPickerView = UIPickerView()
    var monthPickerView = UIPickerView()
    var weekPickerView = UIPickerView()
    
    var daysPickerView = UIPickerView()
    var countMealPickerView = UIPickerView()
    var mealPickerView = UIPickerView()
    var monthcount:Int?
    var mealcount: Int?
    var mcount: String?
    var users = [User]()
    var meals = [DayMeal]()
    var meal1: DayMeal?
    var arrayOfTotalyMeal = [DayMeal]()
    var countmealscals = [DayMeal]()
    var totalC:Double?
    var testc = [Double]()
    var testS = [String]()
    var snewmonth: Bool?
    var monthc:Int?
    var removemonth: Int?
    var monthcS:String?
    var dayArry = ["day1","day2","day3","day4","day5","day6","day7"]
    var mcal:String?
    var weekArray = ["week1","week2","week3","week4"]
    var monthArray = ["month1","month2","month3","month4"]
//    var monthArray = ["month1","month2","month3","month4","month5","month6","month7","month8","month9","month10","month11","month12"]
    let countMeal = ["1","2","3","4","5","6","7","8","9","10","11","12"]
    //let mealsArray = ["كفته ","سمك ","بيض","كزبرة ","خبزة"]
     var week: String?
    // global variabls to print the selected row
    var selectedTrainer : User?
    var selectedDays : String?
    var selectedCountMeal : String?
    var selectedMeal : DayMeal?
    var selectedMonth : String?
    var selectedWeek : String?
    var weekcount:Int?
    var daycount:Int?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView.tag == 1){
            return users[row].profile.userEmail
        }else if (pickerView.tag == 2){
            return dayArry[row]
        }else if (pickerView.tag == 3){
            return countMeal[row]
        }else if (pickerView.tag == 5){
            return monthArray[row]
        }else if (pickerView.tag == 6){
           return weekArray[row]
        }else{
            return meals[row].name
        }
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView.tag == 1){
            return (users.count)
        }else if (pickerView.tag == 2){
            return dayArry.count
        }else if (pickerView.tag == 3){
            let mcount = mealcount! + 1
            return mcount
//            return countMeal.count
        }else if (pickerView.tag == 5){
//             monthc = 0
//            if monthcount! < 12{
//            monthc = monthcount!
//
//            }
//            return (monthc! + 1)
        return monthArray.count
        
    }else if (pickerView.tag == 6){
           return weekArray.count
    }else{
            return meals.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        print(pickerView.tag)
        if (pickerView.tag == 1){
            selectedTrainer = User.init(diet: users[row].diet, exercises: users[row].exercises, profile: users[row].profile)
            trainerPickerTf.text = selectedTrainer?.profile.userEmail
            getmonthscount()
        }else if (pickerView.tag == 2){
//            testS.removeAll()
//            testc.removeAll()
            selectedDays = "\(row)"
            let days = dayArry[row]
            
            daysPickerTf.text = days
            getmealscount()
//            gettotalcals()
            if row == Int(selectedDays!){
//                getmealscount()
//                gettotalcals()
            }
//            if mcount != nil{
//                     let mealcountRef = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!)
//            let dayexecount = ["mealsCount": self.mcount!] as [String : Any]
//            mealcountRef.updateChildValues(dayexecount as [AnyHashable : Any])
//            }
//            countcals()
        }else if (pickerView.tag == 3){
            selectedCountMeal = "\(row)"
            let mealsnum = countMeal[row]
            countOfMealTf.text = mealsnum
//            gettotalcals()
//            if Int(selectedCountMeal!) != mealcount! + 1 {
//                        gettotalcals()
//            }
//            getmealscount()
//                    let mealcountRef = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!)
//                        let dayexecount = ["mealsCount": "\(self.mealcount! + 1)"] as [String : Any]
//                        mealcountRef.updateChildValues(dayexecount as [AnyHashable : Any])
//            gettotalcals()
//            countcals()
//            testS.removeAll()
//            testc.removeAll()
        }else if (pickerView.tag == 5){
            selectedMonth = "\(row)"
            let Months = monthArray[row]
            monthTf.text = Months
//            if Int(selectedMonth!) == (monthcount! )   && monthcount! < 12{
//                snewmonth = true
//                                newmonth()
//            }
//
//
//            else {
//                snewmonth = false
//                 removemonth = (Months.count )
//                let monthref = Database.database().reference().child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet")
//                monthref.child("\(removemonth!)").removeValue()
//
////                let monthref = Database.database().reference().child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet")
////                monthref.child(monthcS!).setValue(nil)
//
//            }
//            if Int(selectedMonth!) != (monthcount! ){
//                removemonth = (Months.count )
//                let monthref = Database.database().reference().child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet")
//                monthref.child("\(removemonth!)").removeValue()
//            }
//            print("\(snewmonth)")
//            else if Int(selectedMonth!) != (monthcount! ) {
//                       let monthref = Database.database().reference().child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet")
//                monthref.child("\(monthcount!)").removeValue()
////                snewmonth = false
//            }

        }else if(pickerView.tag == 6){
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
        }else{
            selectedMeal = DayMeal.init(cal: meals[row].cal, elements: meals[row].elements, image: meals[row].image, ingredients: meals[row].ingredients, name: meals[row].name)
            mealPickerTf.text = selectedMeal?.name
//      mcal = selectedMeal?.cal
//            getmealscount()


                
            
//            getmealscount()
//            gettotalcals()
//            gettotalcals()
            do{
                
                let imgURL = self.meals[row].image
                let url = URL(string: imgURL)
                //            let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/vego-6.appspot.com/o/exercises%2F2?alt=media&token=b90ad507-4a4c-447a-97d4-6ea05e2265d8")
                let data = try Data(contentsOf: url!)
                //            let gif = UIImage.gifI
                self.imageView.image = UIImage(data: data)
            }
            catch{
                print(error)
            }
        }
        
    }
    
//    func newmonth(){
//       let monthref = Database.database().reference().child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet")
//
////        let sum = self.testc.reduce(0) { $0 + $1 }
////        print("\(sum)")
////        let daynum = String((Int(selectedDays!)! + 1))
////        let data = try! FirebaseEncoder().encode(self.selectedMeal)
////
////        let daymeals = ["\(self.selectedCountMeal!)": data]
////        let daylymeals = ["day": daynum
////            ,"dayMeals": ""
////            ,"mealsCount": ""
////            ,"totalCals": ""] as [String : Any]
////
////        let dietchild = ["0": daylymeals]
////        let dietweeks = ["week1":dietchild,
////                         "week2":dietchild,
////                         "week3":dietchild,
////                         "week4":dietchild]
////        let dietmonth = ["\(self.selectedMonth!)": dietweeks]
//        let ingredientschild = ["quantity": String()
//            ,"type": String()]
//
//        let ingredients = ["0": ingredientschild]
//
//        let elementchild = ["amount": String()
//            ,"name":String()]
//
//        let element = ["0": elementchild]
//
//        let daymealschild = ["cal": String()
//            ,"elements":element
//            ,"image": String()
//            ,"ingredients": ingredients
//            ,"name": String()] as [String : Any]
//
//        let daymeals = ["0": daymealschild]
//
//        let daylymeals = ["day": String()
//            ,"dayMeals": daymeals
//            ,"mealsCount": String()
//            ,"totalCals": String()] as [String : Any]
//
//        let dietchild = ["0": daylymeals,
//                         "1": daylymeals,
//                         "2": daylymeals,
//                         "3": daylymeals,
//                         "4": daylymeals,
//                         "5": daylymeals,
//                         "6": daylymeals]
//        let dietweeks = ["week1":dietchild,
//                         "week2":dietchild,
//                         "week3":dietchild,
//                         "week4":dietchild]
////        let dietmonth = ["0": dietweeks]
//        let dietmonth = ["\(self.selectedMonth!)": dietweeks]
//        monthref.updateChildValues(dietmonth as Any as! [AnyHashable : Any])
////        getmealscount()
////        gettotalcals()
//
//
//
//
//
//
//
//    }
    
    func gettotalcals(){
   
       let mealcalsRef = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!)

//        self.testS.removeAll()
//        self.testc.removeAll()
        
                let userRef = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!).child("dayMeals")
        userRef.observeSingleEvent(of: .value) { (snapshot) in


   
//                userRef.observe(.value, with:  { (snapshot) in
//                    self.testS.removeAll()
//                    self.testc.removeAll()

                    let it: Int = Int(snapshot.childrenCount)
                    for i in 0..<it{
                        userRef.child("\(i)") .observeSingleEvent(of: .value) { (snapshot) in
//                        userRef.child("\(i)").observe(.value, with:  { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let cal = value!["cal"] as! String
//                            print(cal)
//                            self.testc[i] = Double(cal)!
                            if cal != ""  {
//                                self.totalC = 0.0
                            self.testc.append(Double(cal)!)
                            self.testS.append(cal)
                                
                            }
                            
                        }
//                        ){ (error) in
//                            print(error.localizedDescription)
//                        }
                        }
//                    self.totalC = self.testc.reduce(0) { $0 + $1 }
//                    let dayexecount = ["totalCals": "\(self.totalC!)"] as [String : Any]
//                    mealcalsRef.updateChildValues(dayexecount as [AnyHashable : Any])

        }
//        ){ (error) in
//            print(error.localizedDescription)
//        }
        self.totalC = self.testc.reduce(0) { $0 + $1 }
        let dayexecount = ["totalCals": "\(self.totalC!)"] as [String : Any]
        mealcalsRef.updateChildValues(dayexecount as [AnyHashable : Any])
        print("\(self.testS)")
        print("\(self.totalC)")
//        self.testS.removeAll()
//        self.testc.removeAll()
        
    }
    func getmonthscount(){
        
        
        let monthref = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet")

        monthref.observe( .value, with:{ snapshot in
            self.monthcount = Int(snapshot.childrenCount)
            self.monthcS = String(Int(snapshot.childrenCount))

            
        }){ (error) in
            print(error.localizedDescription)
        }
        
    }
    func getmealscount(){
        
        
        
        let mealcountRef = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!)
       
       self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!).child("dayMeals").observeSingleEvent(of: .value) { (snapshot) in
//        self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!).child("dayMeals").observe( .value, with:{ snapshot in
        
            
            self.mcount = String(Int(snapshot.childrenCount))
            self.mealcount = Int(snapshot.childrenCount)
            
            let dayexecount = ["mealsCount": self.mcount!] as [String : Any]
            mealcountRef.updateChildValues(dayexecount as [AnyHashable : Any])

//            self.testS.removeAll()
//            self.testc.removeAll()
        
        }
//        ){ (error) in
//            print(error.localizedDescription)
//        }
    
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

        
    }
    
    
    func addMealToUser(){
        
        // Append to array
        if selectedMeal != nil {
            
            arrayOfTotalyMeal.append(selectedMeal!)
        }else{
            print("Error")
        }

            let userRef = ref.child("users").child((selectedTrainer?.profile.uid)!).child("Diet").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!).child("dayMeals").child(self.selectedCountMeal!)
            
            let data = try! FirebaseEncoder().encode(self.selectedMeal)
            userRef.updateChildValues(data as! [AnyHashable : Any])
                    updateMealDetials()
//        }



    }
    func updateMealDetials (){
        if selectedMeal != nil {


            let updateDitailsMeal = ref.child("users").child((selectedTrainer?.profile.uid)!).child("Diet").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!)

            let mealChild = ["day" :  String((Int(selectedDays!)! + 1))] as [String : Any]
            
            updateDitailsMeal.updateChildValues(mealChild)

        }else{
            print("Error")
        }

    }
    
    
    
    
    
    func getMeals(){
        ref.child("meals").observe(.value, with: { (snapshot) in
            
            do {
                // Get user value
                
                for snap in snapshot.children {
                    let userSnap = snap as! DataSnapshot
                    let jsonData = try JSONSerialization.data(withJSONObject: userSnap.value)
                    self.meals.append(try! JSONDecoder().decode(DayMeal.self, from: jsonData))
                }
                self.mealPickerView.reloadAllComponents()
                //print(value)
            } catch let error {
                print(error)
            }
            
            // guard let value = snapshot.value as? [String: Any] else { return }
            // ...
        }){ (error) in
            print(error.localizedDescription)
        }

        
    }

    @IBAction func saveMealBt(_ sender: Any) {
        
        if (trainerPickerTf.text != "" && monthTf.text != "" && weekTf.text != "" && daysPickerTf.text != "" && countOfMealTf.text != "" && mealPickerTf.text != ""){
        let userRef = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child(self.selectedMonth!).child(self.week!).child(self.selectedDays!).child("dayMeals")
        userRef.observe(.value, with:  { (snapshot) in

            self.getmealscount()

        }){ (error) in
            print(error.localizedDescription)
        }
        addMealToUser()
            self.showALert(titel: "", message: "تم حفظ الوجبات ")
        }else{
             self.showALert(titel: "تحذير !", message: "لم تدخل كامل بيانات الوجبة")

    }
    }
        func showALert(titel : String , message: String){
            let alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (action) in
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
        }
    

    
    
    func designPieckerTextField(){
        //creat tool bar in picker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        // creat done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(daiteAdmin.donePressed))
        
        
        toolBar.setItems([doneButton], animated: true)
        
        
        // creat picker for every text field
        trainerPickerTf.inputView = trainerPickerView
        trainerPickerTf.inputAccessoryView = toolBar
        
        monthTf.inputView = monthPickerView
        monthTf.inputAccessoryView = toolBar
        
        weekTf.inputView = weekPickerView
        weekTf.inputAccessoryView = toolBar
        
        daysPickerTf.inputView = daysPickerView
        daysPickerTf.inputAccessoryView = toolBar
        
        countOfMealTf.inputView = countMealPickerView
        countOfMealTf.inputAccessoryView = toolBar
        
        mealPickerTf.inputView = mealPickerView
        mealPickerTf.inputAccessoryView = toolBar
        
        
        
        
    }
    func ubdateCals(){
    let dietref = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet")
    dietref.observeSingleEvent(of: .value) { (snapshot) in
        
        self.monthcount = Int(snapshot.childrenCount)
        self.monthcS = String(Int(snapshot.childrenCount))
        for im in 0..<self.monthcount!{
        let monthref = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child("\(im)")
            monthref.observeSingleEvent(of: .value) { (snapshot1) in
             self.weekcount = Int(snapshot1.childrenCount)
                for iw in 0..<self.weekcount!{
                    
                    let weekref = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child("\(im)").child(self.weekArray[iw])
            weekref.observeSingleEvent(of: .value) { (snapshot2) in
                self.daycount = Int(snapshot2.childrenCount)
                for id in 0..<self.daycount!{
                    let udayref = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child("\(im)").child(self.weekArray[iw]).child("\(id)")
                    let dayref = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child("\(im)").child(self.weekArray[iw]).child("\(id)").child("dayMeals")
                dayref.observeSingleEvent(of: .value) { (snapshot3) in
                
                    let it: Int = Int(snapshot3.childrenCount)
                    for itt in 0..<it{
                           let melref = self.ref.child("users").child((self.selectedTrainer?.profile.uid)!).child("Diet").child("\(im)").child(self.weekArray[iw]).child("\(id)").child("dayMeals")
//                        dayref.child("\(i)") .observeSingleEvent(of: .value) { (snapshot) in
                        melref.child("\(itt)").observeSingleEvent(of: .value) { (snapshot4)  in
                            let value = snapshot4.value as? NSDictionary
                            if value != nil {
                           
                            let cal = value!["cal"] as? String ?? "0.0"

                                if cal != ""       {
                                    let cals = cal
                             
                                self.testc.append(Double(cal)!)
                                self.testS.append(cals)
//                               self.testc = self.testS.map {Double($0)!}
//                                self.testc = self.testS.map { (value) -> Double? in
//                                    return Double(value)
//                                    } as! [Double]
//
                                }
                                if self.testc.count == it {
                                    print("\(self.testS)")
                         
//                                    self.testc = self.testS.map {Double($0)!}
                                    print("\(self.testc)")
                                    self.totalC = self.testc.reduce(0) { $0 + $1 }
                                    let dayexecount = ["totalCals": "\(self.totalC!)"] as [String : Any]
                                    udayref.updateChildValues(dayexecount as [AnyHashable : Any])

                                    print("\(self.totalC!)")
                                    self.testc.removeAll()
                                    self.testS.removeAll()
                                }
                              
                            }

                            
                        }

                    }

                }

                }
                
                
                
                
            }
                    
                }
                
            

        }
    
  
    
    
        }
    }
    }
    @IBAction func saveprogram(_ sender: UIButton) {
        if (trainerPickerTf.text != ""){
          ubdateCals()
          print("1")
        }else {
            
          self.showALert(titel: "", message: "لم تختر مستخدم")
            
        }
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ref = Database.database().reference()
//        ubdatecalmeals()
        //المتدرب
        trainerPickerView.delegate = self
        trainerPickerView.dataSource = self
        trainerPickerTf.delegate = self
        
        monthPickerView.delegate = self
        monthPickerView.dataSource = self
        monthTf.delegate = self
        
        weekPickerView.delegate = self
        weekPickerView.dataSource = self
        weekTf.delegate = self
        //الايام
        daysPickerView.delegate = self
        daysPickerView.dataSource = self
        daysPickerTf.delegate = self
        // الوجبة الاولى
        countMealPickerView.delegate = self
        countMealPickerView.dataSource = self
        countOfMealTf.delegate = self
        //الوجبة الثانية
        mealPickerView.delegate = self
        mealPickerView.dataSource = self
        mealPickerTf.delegate = self
        
        
        // show the input as picker choises
        trainerPickerView.tag = 1
        daysPickerView.tag = 2
        countMealPickerView.tag = 3
        mealPickerView.tag = 4
        monthPickerView.tag = 5
        weekPickerView.tag = 6
        
        designPieckerTextField()
        
        getTrainer()
        getMeals()
        // editeMeal()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if CheckInternet.Connection() {
            
            print("internet is connected ")
            
        }else {
            self.showALert(titel: "تنبيه ! ", message: "الاتصال بالنترنت ضعيف او مقطوع ")
            print("internet is not connected ")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //this function heddin picker when we prees the done button
    @objc func donePressed(_ sender: UIBarButtonItem) {
        
  
        trainerPickerTf.resignFirstResponder()
        monthTf.resignFirstResponder()
        weekTf.resignFirstResponder()
        daysPickerTf.resignFirstResponder()
        countOfMealTf.resignFirstResponder()
        mealPickerTf.resignFirstResponder()
       
        
        
        
    }
    
    
    
    
}



