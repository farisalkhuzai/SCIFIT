//
//  dailymealVC.swift
//  vegoLogo
//
//  Created by Faris Alkhuzai on 09/11/1439 AH.
//  Copyright © 1439 Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
class dailymealVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    
    
    var diet:DietWeeks?
    
    var ref:DatabaseReference!
    @IBOutlet weak var DailymealTV: UITableView!
    @IBOutlet weak var Daylabel: UILabel!
    var selectedmeal: DayMeal!
    var selectedmealname:String!
    var selectedImage:String!
//    @IBOutlet weak var dayNavi: UINavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
//        dayNavi.topItem?.title = "يوم " + (diet?.day)!
        self.DailymealTV.reloadData()
        DailymealTV!.delegate = self
        DailymealTV!.dataSource = self
        //        self.trainingDetialsTable.reloadData()
        DailymealTV.separatorColor = UIColor(white: 0.95, alpha: 1)
        Daylabel.text = "يوم " + (diet?.day)!
        
        
        
        
        
//        self.dayNavi.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "TheSans", size: 17)!]
//     self.DailymealTV.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (diet!.dayMeals.count)
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DailymealTV.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! dailymealTableViewCell
        
        //        userInfo.diet[indexPath.row].dayMeals[indexPath.row].mealName
        //        userInfo.diet[indexPath.row].dayMeals[indexPath.row].mealCal
        // Configure the cell...
        //        cell.mealsLable.text = diet?.dayMeals[indexPath.row].mealName
        //        cell.calLable.text = diet?.dayMeals[indexPath.row].mealCal
        cell.mealsLable.text = diet?.dayMeals[indexPath.row].name
        let cal: Double = Double((diet?.dayMeals[indexPath.row].cal as! String))!
        cell.calLable.text = "\(cal)"

        //            cell.mealsLable.text = diet!.dayMeals[indexPath.row].mealName
        //            cell.calLable.text = diet!.dayMeals[indexPath.row].mealCal
        //
        DispatchQueue.global().async {
        do{
            let imgURL = self.diet?.dayMeals[indexPath.row].image

            //            let imgURL = self.exercise[indexPath.row].image
            let url = URL(string: imgURL!)
            //            let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/vego-6.appspot.com/o/exercises%2F2?alt=media&token=b90ad507-4a4c-447a-97d4-6ea05e2265d8")
            let data = try Data(contentsOf: url!)
            //            let gif = UIImage.gifI
            DispatchQueue.main.async {
            cell.mealImg.image = UIImage(data: data)
            }
            //            cell.exerImg.image = UIImage(data: data)
            //            self.exerciseimg.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        }
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedmeal = diet?.dayMeals[indexPath.row]
        self.selectedmealname = diet?.dayMeals[indexPath.row].name
        self.selectedImage = diet?.dayMeals[indexPath.row].image
        self.performSegue(withIdentifier: "seguedet", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguedet"  {
            if let destinationVC = segue.destination as? mealdetailsVC {
                destinationVC.meal = self.selectedmeal
                destinationVC.mealname = self.selectedmealname
                destinationVC.mealImg = self.selectedImage
                
                //                destinationVC.mealDNavi =
            }
        }
}
}
