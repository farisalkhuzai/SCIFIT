//
//  dietVC.swift
//  vegoLogo
//
//  Created by Faris Alkhuzai on 05/11/1439 AH.
//  Copyright © 1439 Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase

class dietVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var month:Int?
    var diet: String?
//    @IBOutlet weak var ditePrNavi: UINavigationBar!
    var userInfo:User?
    
    //referance for database
    var ref:DatabaseReference!
    @IBOutlet weak var DietTV: UITableView!
    var selectedDiet:DietWeeks?
    var Diet = [DietWeeks]()
    var DietMeal = [DayMeal]()
    var testc = [Double]()
    var testS = [String]()
    var totCals = [String]()
    
 
    
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
    ////
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            // print("this is the last cell")
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.DietTV.tableFooterView = spinner
            self.DietTV.tableFooterView?.isHidden = false
        }
    }
    /////
    override func viewDidAppear(_ animated: Bool) {
        if CheckInternet.Connection() {
            
            print("internet is connected ")
            
        }else {
            self.showALert(titel: "تنبيه ! ", message: "الاتصال بالنترنت ضعيف او مقطوع ")
            print("internet is not connected ")
        }
    }
    func showALert(titel : String , message: String){
        let alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        // load the data from server
        loadData()
//        gettotalcals()
        DietTV.separatorColor = UIColor(white: 0.95, alpha: 1)

        DietTV.delegate = self
        DietTV.dataSource = self
        self.DietTV.reloadData()
        // loading to reload data from firebase
//        loading.isHidden = true
//        DietTV.isHidden = true
//        loadingActivityIndecator()
//        self.ditePrNavi.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "TheSans", size: 17)!]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
       
    }
    
    func loadData(){
        // change it from sign in
        let userID = Auth.auth().currentUser?.uid
        ///let userID = "ZU7wS37XJUU6oeueYlciKWxx5X23"
        ref.child("users").child(userID!).child("Diet").child("\(String(describing: month))").child(diet!).observe(.value, with: { (snapshot) in
            
            guard let value = snapshot.value as? [String: Any] else { return }
            do {
                // Get user value
                let jsonData = try JSONSerialization.data(withJSONObject: value)
//                self.Diet = try! JSONDecoder().decode([DietWeeks].self, from: jsonData)
                self.Diet.append(try! JSONDecoder().decode(DietWeeks.self, from: jsonData))
//                self.DietTV.isHidden = false;
//                self.loading.stopAnimating()
                self.DietTV.reloadData()
                self.DietTV.reloadData()
                self.DietTV.isHidden = false
//                self.gettotalcals()
                
            } catch let error {
                print(error)
            }
//            self.gettotalcals()
            // ...
        }){ (error) in
            print(error.localizedDescription)
        }



    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        if userInfo == nil  {
//            return 0
//        } else {
        return (Diet.count)
//        }
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DietTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! dietVCTableViewCell
        let cal = Diet[indexPath.row].totalCals
//        let cal = userInfo?.diet[indexPath.row].totalCals
//        let cal : Double = Double((userInfo?.diet[indexPath.row].totalCals as! String))!
        cell.mealsLable.text = Diet[indexPath.row].mealsCount
//        cell.mealsLable.text = Diet[indexPath.row]
        cell.daysLable.text = "يوم " + (Diet[indexPath.row].day)
        cell.calLable.text = cal
//        self.gettotalcals()
//        cell.calLable.text = totCals[indexPath.row]
        let mealcount = Diet[indexPath.row].mealsCount
//        let mealcount: Int = Int((userInfo?.diet[indexPath.row].mealsCount as! String))!
        cell.mealsLable.text = "عدد الوجبات: " + mealcount
        // Configure the cell...
        if cell.daysLable.text  != "يوم " && cell.calLable.text != nil && cell.mealsLable.text != "عدد الوجبات: "{
            cell.calenderImage.isHidden = false
            cell.calImage.isHidden = false
            cell.plateImage.isHidden = false
            cell.daysLable.isHidden = false
            cell.calLable.isHidden = false
            cell.mealsLable.isHidden = false
        }else {
            cell.calenderImage.isHidden = true
            cell.calImage.isHidden = true
            cell.plateImage.isHidden = true
            cell.daysLable.isHidden = true
            cell.calLable.isHidden = false
            cell.mealsLable.isHidden = true
            cell.calLable.text = "  راحه  "
            cell.isUserInteractionEnabled = false
        }
        return cell
    }


     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        self.selectedDiet = userInfo?.diet[indexPath.row]
        self.selectedDiet = Diet[indexPath.row]
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
