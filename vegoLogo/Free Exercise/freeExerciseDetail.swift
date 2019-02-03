//
//  freeExerciseDetail.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢٣ محرم، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import SwiftGifOrigin

class freeExerciseDetail: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ref:DatabaseReference!
    var sets = [Set]()
//    var sets1 = [Set]()
    var month:Int!
    var exercise: String?
    var daysnumber:Int!
    var volume = [Int]()
    var RM1 = [Double]()
    
    var mucle: String?
    var name: String?
    var image: String?
    
    @IBOutlet weak var imageExercise: UIImageView!
    @IBOutlet weak var moucel: UILabel!
    @IBOutlet weak var nameExercise: UILabel!
    @IBOutlet weak var maxVolume: UILabel!
    
    @IBOutlet weak var maxRm1: UILabel!
    @IBOutlet weak var setsTableView: UITableView!
    
    @IBOutlet weak var biggerExerciseImage: UIView!
    @IBOutlet weak var exerciseImageZoom: UIImageView!
    
    
  
    @IBAction func closeBigerImg(_ sender: Any) {
        biggerExerciseImage.isHidden = true
    }
    
    @IBAction func openBiggerImage(_ sender: Any) {
         biggerExerciseImage.isHidden = false
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
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
        setsTableView.delegate = self
        setsTableView.dataSource = self
        nameExercise.text = name
        moucel.text = mucle
        do{
            let imgURL = image
            
            //            let imgURL = self.exercise[indexPath.row].image
            let url = URL(string: imgURL!)
            //            let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/vego-6.appspot.com/o/exercises%2F2?alt=media&token=b90ad507-4a4c-447a-97d4-6ea05e2265d8")
            let data = try Data(contentsOf: url!)
            //            let gif = UIImage.gifI
            imageExercise.image = UIImage.gif(data: data)
           
        }
        catch{
            print(error)
        }
      
    }
  
    @IBAction func closeExerciseImage(_ sender: Any) {
        self.biggerExerciseImage.isHidden = true
    }
    
    @IBAction func openExerciseImage(_ sender: Any) {
        UIView.animate(withDuration: 1, animations: {
            self.biggerExerciseImage.isHidden = false
            
        }, completion: nil)
        
        exerciseImageZoom.image = imageExercise.image
    }
        // Do any additional setup after loading the view.
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
        return sets.count
        
    }
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //
    //        return (sets.sets.count)
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        ref = Database.database().reference()
        //        let userID = Auth.auth().currentUser?.uid
        let cell = tableView.dequeueReusableCell(withIdentifier: "execell", for: indexPath) as! setsFreeExerciseTable
//        cell.repsLabel.text = "\(sets[indexPath.row].reps)"
////        //        cell.weightuser.text = sets.sets[indexPath.row].weight
////        //        cell.volumecalc.text = sets.sets[indexPath.row].volume
////        //        cell.rm1calc.text = sets.sets[indexPath.row].rm1
//        if sets[indexPath.row].weight != nil{
//            cell.weightLabel.text = sets[indexPath.row].weight
//            cell.rmaLabel.text = sets[indexPath.row].rm1
//            cell.volumeLabel.text = sets[indexPath.row].volume
//
//        }
        
        cell.setLabel.text = String(indexPath.row + 1)
        
        return cell
    }
    @IBAction func addSetButton(_ sender: Any) {
        sets.reserveCapacity(4)
        if (sets.count) < 4 {
            sets.append(Set(reps: "0", rm1: "", volume: "", weight: ""))
        }
        setsTableView.reloadData()
    }
    @IBAction func calculate(_ sender: UIButton) {
        maxnumber()
        
        let maxr = RM1.max()
        if maxr != nil{
            let maxr2 = Double(round(100*maxr!)/100)
            maxRm1.text = "\(Double(maxr2))"
            let maxv = volume.max()
            maxVolume.text = "\(Int(maxv!))"
            volume.removeAll()
            RM1.removeAll()
         
        }
    }
    func maxnumber(){
        ref = Database.database().reference()
        
        for i in 0..<sets.count {
            let indexpath = IndexPath(row: i, section: 0)
            let cell = setsTableView.cellForRow(at: indexpath)! as! setsFreeExerciseTable
            if cell.weightLabel.text != "" {
                
                volume.append(Int((cell.volumeLabel.text!))!)
                RM1.append(Double((cell.rmaLabel.text as! String))!)
            }
            //                self.ref.child("test").updateChildValues(data as! [AnyHashable : Any])
        }
        
    }
    
    @IBAction func deleteset(_ sender: UIButton) {
        if sets.isEmpty == false{
        sets.removeLast()
        }
        setsTableView.reloadData()

        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        append()
     
    }
    
}
    




