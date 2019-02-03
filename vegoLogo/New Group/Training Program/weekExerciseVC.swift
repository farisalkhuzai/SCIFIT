//
//  weekExerciseVC.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٥ صفر، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
class weekExerciseVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var exercise:Exercise?
    var month:Int?
    var ref:DatabaseReference!
    
    @IBOutlet weak var weeksTV: UITableView!
    var weeks : String?
    var selectedmonth =  [ExerciseWeeks]()
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
        ref = Database.database().reference()
        loadData()
        //        dayNavi.topItem?.title = "يوم " + (diet?.day)!
        self.weeksTV.reloadData()
        weeksTV!.delegate = self
        weeksTV!.dataSource = self
        //        self.trainingDetialsTable.reloadData()
        weeksTV.separatorColor = UIColor(white: 0.95, alpha: 1)
        //        Daylabel.text = "يوم " + (diet?.day)!
        
        
        
        
        //        self.dayNavi.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "TheSans", size: 17)!]
        //     self.DailymealTV.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        // Do any additional setup after loading the view.
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func loadData(){
        
        // change it from sign in
        let userID = Auth.auth().currentUser?.uid
        ///let userID = "ZU7wS37XJUU6oeueYlciKWxx5X23"
        ref.child("users").child(userID!).child("Exercises").child("\(month)").observe(.value, with: { (snapshot) in
            
            guard let value = snapshot.value as? [String: Any] else { return }
            do {
                // Get user value
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                self.exercise = try? JSONDecoder().decode(Exercise.self, from: jsonData)
                
                //  self.loading.isHidden = true
                self.weeksTV.isHidden = false;
                //                self.loadView.stopAnimating()
                self.weeksTV.reloadData()
                //print(value)
            } catch let error {
                print(error)
            }
            
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
        return (4)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weeksTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! weekExerciseCell
        //        cell.weekLabel.text = diet?.month[indexPath.row]
        let weeknumber = (indexPath.row) + 1
        cell.weekLabel.text = "الأسبوع" + "\(weeknumber)"
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weeknumber = (indexPath.row) + 1
        self.weeks = "week" + "\(weeknumber)"
        if weeknumber == 1 {
            self.selectedmonth = (exercise?.week1)!
            
        }
        if weeknumber == 2 {
            self.selectedmonth = (exercise?.week2)!
            
        }
        if weeknumber == 3 {
            self.selectedmonth = (exercise?.week3)!
            
        }
        if weeknumber == 4 {
            self.selectedmonth = (exercise?.week4)!
            
        }
        
        self.performSegue(withIdentifier: "segueweek", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueweek"  {
            if let destinationVC = segue.destination as? trainingProgram {
                destinationVC.exercise = self.weeks
                destinationVC.month = self.month
                destinationVC.Exercise = self.selectedmonth
                
                //                destinationVC.mealDNavi =
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
