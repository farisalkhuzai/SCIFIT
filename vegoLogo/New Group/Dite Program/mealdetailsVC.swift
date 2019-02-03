//
//  mealdetailsVC.swift
//  vegoLogo
//
//  Created by Faris Alkhuzai on 10/11/1439 AH.
//  Copyright © 1439 Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase




class mealdetailsVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var diet:Diet?
    
    
    var meal: DayMeal?
    var ingredients = [Ingredient]()
    
    var elements = [Element]()
    var mealname: String!
    var mealImg: String!
    //    var mealing: MealIngr!
    //    var mealQuintity = ["100g","50g","50g"]
    //    var mealType = ["chicken","brokly","rice"]
    //
    //    var foodEle: [String] = ["السعرات", "بروتين", "نشويات", "دهون"]
    //
    //    var foodQuintity: [String] = ["500","غ250","غ200","غ20"]
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var label2: UIView!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var mealDNavi: UINavigationBar!
    @IBOutlet weak var firstTable: UITableView!
    
    
    @IBOutlet weak var secondTable: UITableView!
    
    @IBOutlet weak var mealImage: UIImageView!
    
    @IBOutlet weak var mealCals: UILabel!
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
        
        
        
        firstTable.delegate = self
        secondTable.delegate = self
        self.firstTable.reloadData()
        self.secondTable.reloadData()
        firstTable.dataSource = self
        secondTable.dataSource = self
        self.mealDNavi.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "TheSans", size: 17)!]
        mealCals.text = meal?.cal
        mealDNavi.topItem?.title = mealname
        DispatchQueue.global().async {
        do{
            let imgURL = self.mealImg
            
            //            let imgURL = self.exercise[indexPath.row].image
            let url = URL(string: imgURL!)
            //            let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/vego-6.appspot.com/o/exercises%2F2?alt=media&token=b90ad507-4a4c-447a-97d4-6ea05e2265d8")
            let data = try Data(contentsOf: url!)
            //            let gif = UIImage.gifI
            DispatchQueue.main.async {
            self.mealImage.image = UIImage(data: data)
            }
            //            cell.exerImg.image = UIImage(data: data)
            //            self.exerciseimg.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        }
        //            mealDNavi.topItem?.title = "وجبة \(diet?.dayMeals.count)"
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.

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
        if (tableView == firstTable){
            return (meal?.ingredients.count)!
        }else{
            return (meal?.elements.count)!
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == firstTable){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! TableViewCell1
            //            cell.mealtype.text = mealType[indexPath.row]
            //            cell.mealquintity.text = mealQuintity[indexPath.row]
            //            cell.mealtype.text = diet?.dayMeals[indexPath.row].ingredients[indexPath.row].type
            //            cell.mealquintity.text = diet?.dayMeals[indexPath.row].ingredients[indexPath.row].quintity
            cell.mealtype.text = meal?.ingredients[indexPath.row].type
            cell.mealquintity.text = meal?.ingredients[indexPath.row].quantity
            //            for i in 0..<(ingredients.count) {
            //                let indexpath = IndexPath(row: i, section: 0)
            ////                cell = firstTable.cellForRow(at: indexpath)! as! TableViewCell1
            //                 cell.mealtype.text! = ingredients[i].type
            //                  cell.mealquintity.text! = ingredients[i].quintity
            //            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TableViewCell2
            //            cell.foodele.text = foodEle[indexPath.row]
            //            cell.foodmelquintity.text = foodQuintity[indexPath.row]
            //            cell.foodele.text = diet?.dayMeals[indexPath.row].elements[indexPath.row].name
            //            cell.foodmelquintity.text = diet?.dayMeals[indexPath.row].elements[indexPath.row].amount
            cell.foodele.text = meal?.elements[indexPath.row].name
            cell.foodmelquintity.text = meal?.elements[indexPath.row].amount
            //            for i in 0..<(elements.count){
            //                let indexpath = IndexPath(row: i, section: 0)
            //                let cell = secondTable.cellForRow(at: indexpath)! as! TableViewCell2
            //                 cell.foodele.text! = elements[indexpath.row].name
            //                 cell.foodmelquintity.text! = elements[indexpath.row].amount
            //            }
            
            return cell
        }
        
        //        userInfo.diet[indexPath.row].dayMeals[indexPath.row].mealName
        //        userInfo.diet[indexPath.row].dayMeals[indexPath.row].mealCal
        // Configure the cell...
        //        cell.mealsLable.text = diet?.dayMeals[indexPath.row].mealName
        //        cell.calLable.text = diet?.dayMeals[indexPath.row].mealCal
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
