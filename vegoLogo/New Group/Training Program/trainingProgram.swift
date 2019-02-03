//
//  trainingProgram.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٥ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase

class trainingProgram: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var month:Int?
    var exercise: String?
    var userInfo:User?
    var ecount = [String]()
    var exercount:Int?
    var execount:String?
    //referance for database
    var ref:DatabaseReference!
//    var selectedExe: Exercise?
    var selcteddaynumber:Int!
    var excount = [ExerciseElement]()
    @IBOutlet weak var trainingProgramTableView: UITableView!
    var selectedExe:ExerciseWeeks?
    var Exercise = [ExerciseWeeks]()
    //    let days = ["يوم 1","يوم 2","يوم 3","يوم 4","يوم 5","يوم 6","يوم 7"]
    //    let exercise = ["باي + صدر","كارديو","اكتاف","ترابيس","بطن", "ظهر + تراي","رجل + افخاض"]
    //    let numberOfExersice = ["7","7","7","7","7","7","7"]
//    let  loading: UIActivityIndicatorView = UIActivityIndicatorView()
//
//    func loadingActivityIndecator(){
//        loading.center = self.view.center
//        loading.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
//        view.addSubview(loading)
//        loading.hidesWhenStopped = true
//        loading.startAnimating()
//
//    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
       
//        loadingActivityIndecator()
        ref = Database.database().reference()
        
        loadData()
     
        ////////////////////(just for designing)//////////////////////////////////////////////////
        trainingProgramTableView.separatorColor = UIColor(white: 0.95, alpha: 1)
        trainingProgramTableView.delegate = self
        trainingProgramTableView.dataSource = self
        // Do any additional setup after loading the view.
//       loading.isHidden = true
//       trainingProgramTableView.isHidden = true
         self.trainingProgramTableView.reloadData()
    }
    func loadData(){
        
        // change it from sign in
        let userID = Auth.auth().currentUser?.uid
        ///let userID = "ZU7wS37XJUU6oeueYlciKWxx5X23"
        ref.child("users").child(userID!).child("Exercises").child("\(String(describing: month))").child(exercise!).observe(.value, with: { (snapshot) in
            
            guard let value = snapshot.value as? [String: Any] else { return }
            do {
                // Get user value
                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                self.Exercise = try! JSONDecoder().decode([ExerciseWeeks].self, from: jsonData)
                self.Exercise.append(try! JSONDecoder().decode(ExerciseWeeks.self, from: jsonData))
//              //  self.loading.isHidden = true
                self.trainingProgramTableView.isHidden = false;
//                self.loading.stopAnimating()
           self.trainingProgramTableView.reloadData()
                //print(value)
            } catch let error {
                print(error)
            }
             self.trainingProgramTableView.reloadData()
            // ...
        }){ (error) in
            print(error.localizedDescription)
        }
        
        
    
        
//        ref.child("users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
//
//            guard let value = snapshot.value as? [String: Any] else { return }
//            do {
//                // Get user value
//                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                self.userInfo = try? JSONDecoder().decode(User.self, from: jsonData)
//                self.trainingProgramTableView.reloadData()
//                //print(value)
//            } catch let error {
//                print(error)
//            }
//
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if userInfo == nil  {
//            return 0
//        } else {
            return (Exercise.count)
//        }
    
    }

        

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trainingProgramTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! trainingCell
        
        //        cell.daysLable.text = days[indexPath.row]
        //        cell.exersiceLable.text = exercise [indexPath.row]
        //        cell.numberOfexLable.text = "عدد التمارين  ت\(numberOfExersice[indexPath.row])"
        //        let cal : Double = Double((userInfo?.diet[indexPath.row].totalCals as! String))!
        //        cell.daysLable.text = userInfo?.diet[indexPath.row].day
        //        cell.calLable.text = String(cal)
  
        cell.daysLable.text = "يوم " + (Exercise[indexPath.row].day)
        cell.exersiceLable.text = Exercise[indexPath.row].targetedmuscles

        cell.numberOfexLable.text = "عدد التمارين:" + "\(Exercise[indexPath.row].exercisecount)"
        
        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)

        if cell.daysLable.text  != "يوم " && cell.exersiceLable.text != nil && cell.numberOfexLable.text != "عدد التمارين:"{
            cell.dayicon.isHidden = false
            cell.muscleicon.isHidden = false
            cell.dumbellicon.isHidden = false
            cell.daysLable.isHidden = false
            cell.exersiceLable.isHidden = false
            cell.numberOfexLable.isHidden = false
        }else {
            cell.dayicon.isHidden = true
            cell.muscleicon.isHidden = true
            cell.dumbellicon.isHidden = true
            cell.daysLable.isHidden = true
            cell.exersiceLable.isHidden = false
            cell.numberOfexLable.isHidden = true
            cell.exersiceLable.text = "  راحه  "
            cell.isUserInteractionEnabled = false
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        self.selectedExe = userInfo?.exercises[indexPath.row]
        self.selectedExe = Exercise[indexPath.row]
        self.selcteddaynumber = indexPath.row
        
        self.performSegue(withIdentifier: "segueexe", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueexe"  {
            if let destinationVC = segue.destination as? trainingDetials {
                destinationVC.exer = self.selectedExe
                destinationVC.daysnumber = self.selcteddaynumber
                destinationVC.month = self.month
                destinationVC.exercise = self.exercise
                
                
            }
        }
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
