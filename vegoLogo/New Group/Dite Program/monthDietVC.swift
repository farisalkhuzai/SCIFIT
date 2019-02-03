//
//  monthDietVC.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٥ صفر، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
class monthDietVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    //    @IBOutlet weak var ditePrNavi: UINavigationBar!
    var user:User?
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var monthTV: UITableView!
    //referance for database
    var ref:DatabaseReference!
    @IBOutlet weak var DietTV: UITableView!
    var selectedmonth:Diet?
    var selectedmonthnumber:Int?
    
    
    
    
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
        // load the data from server
        loadData()
        monthTV.separatorColor = UIColor(white: 0.95, alpha: 1)
        monthTV.delegate = self
        monthTV.dataSource = self
        
        loading.startAnimating()
        
        // loading to reload data from firebase
//        loading.isHidden = true
//        monthTV.isHidden = true
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
        ref.child("users").child(userID!).observe(.value, with: { (snapshot) in

            guard let value = snapshot.value as? [String: Any] else { return }
            do {
                // Get user value
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                self.user = try? JSONDecoder().decode(User.self, from: jsonData)

                self.monthTV.isHidden = false;
//                self.loading.stopAnimating()
                self.monthTV.reloadData()
//                self.monthTV.reloadData()
                self.loading.stopAnimating()
                self.loading.isHidden = true

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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if user == nil  {
            return 0
        } else {
            return (user!.diet.count)
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = monthTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! monthDietCell
//        let diet = user?.diet
//        let index = (diet?.count)!
//
//        for i in 0..<index{
        let monthnumber = (indexPath.row) + 1
        
        
        cell.monthLabel.text = "الشهر" + "\(monthnumber)"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedmonthnumber = indexPath.row
        self.selectedmonth = user?.diet[indexPath.row]
        self.performSegue(withIdentifier: "seguemonth", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguemonth"  {
            if let destinationVC = segue.destination as? weekDietVC {
                destinationVC.month = self.selectedmonthnumber
                destinationVC.diet = self.selectedmonth
                
            }
        }
    }
    
}
