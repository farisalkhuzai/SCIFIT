//
//  exerciseinfoVC.swift
//  vegoLogo
//
//  Created by Faris Alkhuzai on 11/11/1439 AH.
//  Copyright © 1439 Khaled Kutbi. All rights reserved.
//
//,UITableViewDelegate,UITableViewDataSource
import UIKit
import Firebase
import CodableFirebase
import SwiftGifOrigin
class exerciseinfoVC: UIViewController, UITableViewDelegate, UITableViewDataSource , UITextFieldDelegate {
    var ref:DatabaseReference!
    var sets: ExerciseElement!
    var sets1 = [Set]()
    var month:Int!
    var exercise: String?
    var daysnumber:Int!
    var volume = [Int]()
    var RM1 = [Double]()
    //    var theSets = ["1","2","3","4"]
    //    var theReps = ["12","12","10","8"]
    var exerImg: String!
    var exercisename:String!
    var exercisenumber:Int!
    @IBOutlet weak var exename: UILabel!
    @IBOutlet weak var exenumber: UILabel!
    @IBOutlet weak var exerImage: UIImageView!
    //////(in the same view)////////////
    @IBOutlet weak var maxVolume: UILabel!
    
    @IBOutlet weak var maxRm1: UILabel!
    @IBOutlet weak var biggerExerciseImage: UIView!
    @IBOutlet weak var exerciseImageZoom: UIImageView!

    @IBAction func closeExerciseImage(_ sender: Any) {
        self.biggerExerciseImage.isHidden = true
    }
    
    @IBAction func openExerciseImage(_ sender: Any) {
        UIView.animate(withDuration: 1, animations: {
            self.biggerExerciseImage.isHidden = false
            
        }, completion: nil)
        
        exerciseImageZoom.image = exerImage.image
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    ////////////////////////////////////
    @IBOutlet weak var exeinfoTableView: UITableView!
    @IBAction func backButton(_ sender: UIButton) {
        
        
        
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        for i in 0..<sets1.count{
            ref.child("users").child(userID!).child("Exercises").child("\(String( self.month))").child(self.exercise!).child(String(self.daysnumber)).child("exercise").child(String(self.exercisenumber)).child("sets").child(String(i)).observe(.value, with: { snapshot in
                //                print(snapshot.childrenCount)
                //            let i = snapshot.childrenCount
                let indexpath = IndexPath(row: i, section: 0)
                let cell = self.exeinfoTableView.cellForRow(at: indexpath)! as! trainingSetCell
                let value = snapshot.value as? NSDictionary
                let weight = value!["weight"] as! String
                if weight != cell.weightuser.text  {
                    
                    
                    //   الرجاد الضغعط علي زر حفظ
                    self.showALert(titel: "تحذير !", message: "الرجاء الضغط على زر الحفظ")
                    //pupup
                    
                }else if weight == "" {
                    
                    
                    // لابد من ادخال الوزن المستخدم في كل الجلسات
                    self.show2bottunALert(titel: "تحذير !", message: "لابد من ادخال الوزن المرفوع لكل جلسة هل أنت متأكد من الرجوع دون إتمام التمرين")
                    //                    self.showALert(titel: "تحذير !", message: "لابد من ادخال الوزن المرفوع لكل جلسة")
                    //pupup
                }
                //                else{
                ////                    self.show2bottunALert(titel: "تحذير !", message: "هل أنت متأكد من الرجوع دون إتمام التمرين")
                ////                    self.dismiss(animated: true, completion: nil)
                //                }
                
                
                
                //                cell.repsnumber.text = self.sets1[i].reps
                //                self.sets.sets[i].weight = cell.weightuser.text!
                
                
            })
        }
        //        self.dismiss(animated: true, completion: nil)
    }
    func showALert(titel : String , message: String){
        let alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func show2bottunALert(titel : String , message: String){
        let alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "نعم", style: UIAlertActionStyle.default, handler:{ (action) in
            self.dismiss(animated: true, completion: nil)
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "إلغاء", style: UIAlertActionStyle.default, handler:{ (action) in
            
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        

        

//        sensetext()
        exename.text = exercisename
        exenumber.text = "تمرين \(exercisenumber + 1)"
        exeinfoTableView.delegate = self
        self.exeinfoTableView.reloadData()
        //        append()
        exeinfoTableView.dataSource = self
        DispatchQueue.global().async {
        do{
            let imgURL = self.exerImg
            
            //            let imgURL = self.exercise[indexPath.row].image
            let url = URL(string: imgURL!)
            //            let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/vego-6.appspot.com/o/exercises%2F2?alt=media&token=b90ad507-4a4c-447a-97d4-6ea05e2265d8")
            let data = try Data(contentsOf: url!)
            //            let gif = UIImage.gifI
            DispatchQueue.main.async {
                self.exerImage.image = UIImage.gif(data: data)
            }
            //            cell.exerImg.image = UIImage(data: data)
            //            self.exerciseimg.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        }
        //        append()
        //        self.tableView.reloadData()
        //        exeinfoTableView.delegate = self
        //        exeinfoTableView.delegate = self
        // Do any additional setup after loading the view.
        /////////(related to duble press to open big image exercise)//////////////
       

    }
    /////(to make exercise image bigger)/////////////////////
 
  
    
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
        return (sets.sets.count)
        
    }
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //
    //        return (sets.sets.count)
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        ref = Database.database().reference()
        //        let userID = Auth.auth().currentUser?.uid
        let cell = tableView.dequeueReusableCell(withIdentifier: "execell", for: indexPath) as! trainingSetCell
        cell.repsnumber.text = sets.sets[indexPath.row].reps
//        cell.weightuser.text = sets.sets[indexPath.row].weight
//        cell.volumecalc.text = sets.sets[indexPath.row].volume
//        cell.rm1calc.text = sets.sets[indexPath.row].rm1
        if sets.sets[indexPath.row].weight != nil{
            cell.weightuser.text = sets.sets[indexPath.row].weight
            cell.rm1calc.text = sets.sets[indexPath.row].rm1
            cell.volumecalc.text = sets.sets[indexPath.row].volume

        }

        cell.setnumber.text = String(indexPath.row + 1)

        return cell
    }
  func history() {
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        for i in 0..<sets1.count{
            ref.child("users").child(userID!).child("Exercises").child("\(String( self.month))").child(self.exercise!).child(String(self.daysnumber)).child("exercise").child(String(self.exercisenumber)).child("sets").observeSingleEvent(of: .value, with: { snapshot in
                //                print(snapshot.childrenCount)
                //            let i = snapshot.childrenCount

                                let indexpath = IndexPath(row: i, section: 0)
                let cell = self.exeinfoTableView.cellForRow(at: indexpath)! as! trainingSetCell
   
                let data1 = ["rm1": cell.rm1calc.text,
                    "reps": cell.repsnumber.text!,
                    "volume": cell.volumecalc.text,
                    "weight": cell.weightuser.text!]
                                    let data = try! FirebaseEncoder().encode(data1); self.ref.child("users").child(userID!).child("Exercises").child("\(String( self.month))").child(self.exercise!).child(String(self.daysnumber)).child("exercise").child(String(self.exercisenumber)).child("sets").child(String(i)).updateChildValues(data as! [AnyHashable : Any])
                                
            })
        }
    }

        
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        append()
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        for i in 0..<sets1.count{
            ref.child("users").child(userID!).child("Exercises").child("\(String( self.month))").child(self.exercise!).child(String(self.daysnumber)).child("exercise").child(String(self.exercisenumber)).child("sets").observeSingleEvent(of: .value, with: { snapshot in
                //                print(snapshot.childrenCount)
                //            let i = snapshot.childrenCount





                //                let indexpath = IndexPath(row: i, section: 0)
                let cell = self.exeinfoTableView.cellForRow(at: indexPath)! as! trainingSetCell

            })
        }
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
        history()
        }
    }
    func maxnumber(){
        ref = Database.database().reference()
        
        for i in 0..<sets1.count {
            let indexpath = IndexPath(row: i, section: 0)
            let cell = exeinfoTableView.cellForRow(at: indexpath)! as! trainingSetCell
            if cell.weightuser.text != "" {
            
            volume.append(Int((cell.volumecalc.text!))!)
            RM1.append(Double((cell.rm1calc.text as! String))!)
            }
            //                self.ref.child("test").updateChildValues(data as! [AnyHashable : Any])
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


