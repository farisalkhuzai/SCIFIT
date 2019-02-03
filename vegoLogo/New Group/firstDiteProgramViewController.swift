//
//  firstDiteProgramViewController.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٣ محرم، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//


import UIKit
import Firebase

class firstDiteProgramViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    @IBOutlet weak var firstditeVcTableView: UITableView!
    @IBOutlet weak var upperLabel: UILabel!

    var userInfo:User?
    
    //referance for database
    var ref:DatabaseReference!
    
    var selectedDiet:Diet?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        // load the data from server
        loadData()
        
        
        self.firstditeVcTableView.dataSource = self
        self.fir
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func loadData(){
        // change it from sign in
        let userID = Auth.auth().currentUser?.uid
        ///let userID = "ZU7wS37XJUU6oeueYlciKWxx5X23"
        ref.child("users").child(userID!).observe(.value, with: { (snapshot) in
            
            guard let value = snapshot.value as? [String: Any] else { return }
            do {
                // Get user value
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                self.userInfo = try? JSONDecoder().decode(User.self, from: jsonData)
                self.firstditeVcTableView.reloadData()
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
        //            // Get user value
        //            let jsonData = try JSONSerialization.data(withJSONObject: value)
        //            self.userInfo = try? JSONDecoder().decode(User.self, from: jsonData)
        //            self.tableView.reloadData()
        //            //print(value)
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if userInfo == nil  {
            return 0
        } else {
            return (userInfo!.diet.count)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! dietVCTableViewCell
        let cal = userInfo?.diet[indexPath.row].totalCals
        //        let cal : Double = Double((userInfo?.diet[indexPath.row].totalCals as! String))!
        cell.daysLable.text = "يوم " + (userInfo?.diet[indexPath.row].day)!
        cell.calLable.text = cal
        let mealcount = userInfo?.diet[indexPath.row].mealsCount
        //        let mealcount: Int = Int((userInfo?.diet[indexPath.row].mealsCount as! String))!
        cell.mealsLable.text = "عدد الوجبات: " + mealcount!
        // Configure the cell...
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedDiet = userInfo?.diet[indexPath.row]
        self.performSegue(withIdentifier: "seguemeal", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguemeal"  {
            if let destinationVC = segue.destination as? dailymealVC {
                destinationVC.diet = self.selectedDiet
                
            }
        }
    }
    
}
