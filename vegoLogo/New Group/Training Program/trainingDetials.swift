//
//  trainingDetials.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٩ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//
import UIKit

import Firebase

class trainingDetials: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var month:Int?
    var exercise: String?
    
    @IBOutlet weak var daylabel: UILabel!
    var exer: ExerciseWeeks?
    var ref:DatabaseReference!
    var selectedexer: ExerciseElement!
    var selectedexername:String!
    var selectedexenumber: Int!
    var selectedImg: String!
    var daysnumber:Int!
    var selectedsets: [Set]!
    @IBOutlet var trainingDetialsTable: UITableView!
    //    let typeOfExersice = ["Dumbell bench press", "Dumbell bench press","Dumbell bench press","Dumbell bench press","Dumbell bench press","Dumbell bench press","Dumbell bench press"]
    //    let numberOfExersice = ["تمرين1","تمرين2","تمرين3","تمرين4","تمرين5","تمرين6","تمرين7"]
    //    let exersiace = ["صدر","صدر","صدر","صدر","صدر","صدر","صدر","صدر"]
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        // #warning Incomplete implementation, return the number of sections
    //        return 1
    //    }
    
//        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//            // #warning Incomplete implementation, return the number of rows
//            return numberOfExersice.count
//        }
    //    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let detailsCell = trainingDetialsTable.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! trainingDetailsCell
    //
    //        detailsCell.exersiceLable.text = exersiace[indexPath.row]
    //        detailsCell.numberofExersiceLable.text = numberOfExersice[indexPath.row]
    //        detailsCell.typeOfexersiceLable.text = typeOfExersice[indexPath.row]
    //
    //         detailsCell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
    //
    //        return detailsCell
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
        ref = Database.database().reference()
        self.trainingDetialsTable.reloadData()
        trainingDetialsTable!.delegate = self
        trainingDetialsTable!.dataSource = self
        //        self.trainingDetialsTable.reloadData()
        trainingDetialsTable.separatorColor = UIColor(white: 0.95, alpha: 1)
//        daylabel.text = "يوم " + (exer?.day)!
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (exer?.exercise.count)!
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailsCell", for: indexPath) as! trainingDetailsCell
        cell.exernumber.text = "تمرين \(indexPath.row + 1)"
        cell.exername.text = exer?.exercise[indexPath.row].exername
        cell.targetedexer.text = exer?.exercise[indexPath.row].targetedmuscle
        DispatchQueue.global().async {
        do{
            let imgURL = self.exer?.exercise[indexPath.row].image
            //            let imgURL = self.exercise[indexPath.row].image
            let url = URL(string: imgURL!)
            //            let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/vego-6.appspot.com/o/exercises%2F2?alt=media&token=b90ad507-4a4c-447a-97d4-6ea05e2265d8")
            let data = try Data(contentsOf: url!)
            //            let gif = UIImage.gifI
            DispatchQueue.main.async {
            cell.exerImg.image = UIImage(data: data)
            //            self.exerciseimg.image = UIImage(data: data)
            }
            }
        catch{
            print(error)
        }
        }
        print("\(String(describing: exer?.exercise[indexPath.row].exername))")
        print("\(String(describing: exer?.exercise[indexPath.row].targetedmuscle))")
        //        userInfo.diet[indexPath.row].dayMeals[indexPath.row].mealName
        //        userInfo.diet[indexPath.row].dayMeals[indexPath.row].mealCal
        // Configure the cell...
        //        cell.mealsLable.text = diet?.dayMeals[indexPath.row].mealName
        //        cell.calLable.text = diet?.dayMeals[indexPath.row].mealCal
        //        cell.mealsLable.text = diet?.dayMeals[indexPath.row].name
        //        let cal: Double = Double((diet?.dayMeals[indexPath.row].cal as! String))!
        //        cell.calLable.text = "\(cal)"

        //            cell.mealsLable.text = diet!.dayMeals[indexPath.row].mealName
        //            cell.calLable.text = diet!.dayMeals[indexPath.row].mealCal
        //

        cell.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        return cell
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedexer = (exer?.exercise[indexPath.row])!
        self.selectedexername = exer?.exercise[indexPath.row].exername
        self.selectedexenumber = indexPath.row
        self.selectedImg = exer?.exercise[indexPath.row].image
        self.selectedsets = exer?.exercise[indexPath.row].sets
        self.performSegue(withIdentifier: "segueset", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueset"  {
            if let destinationVC = segue.destination as? exerciseinfoVC {
                
                destinationVC.sets = self.selectedexer
                //                destinationVC.exercise = self.selectedexername
                destinationVC.exercisename = self.selectedexername
                destinationVC.exercisenumber = self.selectedexenumber
                destinationVC.daysnumber = self.daysnumber
                destinationVC.exerImg = self.selectedImg
                destinationVC.month = self.month
                destinationVC.exercise = self.exercise
                destinationVC.sets1 = self.selectedsets
                
                //                destinationVC.mealDNavi =
            }
        }
    }
    
    // MARK: - Table view data source
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
