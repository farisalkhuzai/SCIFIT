//
//  adminmealdetailsVC.swift
//  vegoLogo
//
//  Created by Faris Alkhuzai on 11/11/1439 AH.
//  Copyright © 1439 Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase
import FirebaseStorage
import SwiftGifOrigin
class adminmealdetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource , UIImagePickerControllerDelegate, UINavigationControllerDelegate , UITextFieldDelegate{
    var imgURL:String! = nil
    var ref:DatabaseReference!
    var meal: DayMeal?
    
    var ingredients = [Ingredient]()
    
    var elements = [Element]()
    
    var selectedMealQ : String?
    var selectedMealT: String?
    var selectedElmentT : String?
    var selectedElementQ :String?
//    var rdyelements = ["بروتين","كيربوهيدرات","دهون"]
    
    
    var tableview1cell: adminmealdetailsTVCell1!
    var tableview2cell:  adminmealdetailsTVCell2!
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var tableView2: UITableView!
    @IBOutlet weak var mealName: UITextField!
    @IBOutlet weak var totalCalls: UITextField!
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        let profileImageFromPicker = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/gif"
        
        let imageData: Data = UIImageJPEGRepresentation(profileImageFromPicker, 0.5)!
        
        let store = Storage.storage()
        
        let storeRef = store.reference().child("meals/ \(randomString(2))")
        
        let _ = storeRef.putData(imageData, metadata: metadata) { (metadata, error) in
            
            guard let _ = metadata else {
                print("error occurred: \(error.debugDescription)")
                return
            }
            
            storeRef.downloadURL(completion: { (url, error) in
                if error != nil{
                    print(error!)
                    return
                }
                let imgurl = url?.absoluteString
                print(imgurl)
                self.imgURL = imgurl
            })
            self.ImageView.image = profileImageFromPicker
        }
        
        
        
    }
    func refreshMealImage(){
        
        let store = Storage.storage()
        let storeRef = store.reference().child("meals/ \(randomString(2))")
        
        storeRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else {
                let image = UIImage(data: data!)
                self.ImageView.image = image
            }
        }
        
        
    }
    func randomString (_ length: Int) -> String {
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0..<length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        return randomString
    }
    
    @IBAction func addmealImg(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func newMeal(_ sender: UIButton) {
        if (mealName.text != "" && selectedMealQ != "" && selectedMealT != "" && selectedElmentT != "" && selectedElementQ != ""){
            append()
            self.showALert(titel: "", message: "تم اضافة وجبة جديدة ")
        }else {
            self.showALert(titel: "", message: "لم تدخل كامل تفاصيل الوجبة ")
        }
        
       
        
    }
    func showALert(titel : String , message: String){
        let alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func append(){
        ref = Database.database().reference()
        var cals = 0.0
        for i in 0..<ingredients.count {
            let indexpath = IndexPath(row: i, section: 0)
            let cell = tableView1.cellForRow(at: indexpath)! as! adminmealdetailsTVCell1
            ingredients[i].type = cell.mealType.text!
            ingredients[i].quantity = cell.mealQuintity.text!
        }
        for i in 0..<elements.count{
            let indexpath = IndexPath(row: i, section: 0)
            let cell = tableView2.cellForRow(at: indexpath)! as! adminmealdetailsTVCell2
//            elements[i].name = rdyelements[i]
            elements[i].name = cell.elementType.text!
            elements[i].amount = cell.elementQuintity.text!
//            cals += Double(elements[i].amount)!
        }
//        meal?.image = self.imgURL
//        meal?.name = mealName.text!
//        meal?.cal = totalCalls.text!
                meal = DayMeal(cal: totalCalls.text!, elements: elements, image: self.imgURL, ingredients: ingredients, name: mealName.text!)
        //            ingredients[i].name = cell.
        //            ingredients[i].amount = Double(cell.mealQuintity.text)!
        
        //
        //        meal = DayMeal(cal: "\(cals)", elements: elements, ingredients: ingredients, name: mealName.text!)
//        meal = DayMeal.init(cal: "\(cals)", elements: elements, image: imgURL, ingredients: ingredients, name: mealName.text!)
//        ref.child("meals").observe(.value, with: { snapshot in
//            print(snapshot.childrenCount)
//            //            let i = snapshot.childrenCount
//                    let daymealschild = ["cal": self.totalCalls.text!
//                        ,"elements": self.elements
//                        ,"image": self.imgURL
//                        ,"ingredients": self.ingredients
//                        ,"name": self.mealName.text!] as [String : Any]
//            let data = try! FirebaseEncoder().encode(self.meal)
//            self.ref.child("meals").child("\(snapshot.childrenCount)").updateChildValues(data as! [AnyHashable : Any])
//        })
        ref.child("meals").observeSingleEvent(of: .value, with: { snapshot in
            print(snapshot.childrenCount)
            //            let i = snapshot.childrenCount
            let data = try! FirebaseEncoder().encode(self.meal)
//            let daymealschild = ["cal": self.totalCalls.text!
//                ,"elements": self.elements
//                ,"image": self.imgURL
//                ,"ingredients": self.ingredients
//                ,"name": self.mealName.text!] as [String : Any]

            
            self.ref.child("meals").child("\(snapshot.childrenCount)").updateChildValues(data as! [AnyHashable : Any])

//            self.ref.child("meals").child("\(snapshot.childrenCount)").updateChildValues(daymealschild as! [AnyHashable : Any])
        })
        //        var indexpathForPass = NSIndexPath(forRow: 1, inSection: 0)
        //        let passCell =  tableView.cellForRowAtIndexPath(indexpathForPass)! as adminmealdetailsTVCell2
        
        
        
    }
    
    
    @IBAction func newIng(_ sender: UIButton) {
        ingredients.append(Ingredient(quantity: "0", type: ""))
        tableView1.reloadData()
    }
    @IBAction func newElement(_ sender: UIButton) {
        elements.append(Element(amount: "0", name: ""))
        tableView2.reloadData()
    }
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        mealName.delegate = self 
        self.imagePicker.delegate = self
        self.refreshMealImage()
        tableView1.delegate = self
        tableView2.delegate = self
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
        if (tableView == tableView1){
            return ingredients.count
        }else{
            return elements.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(tableView == tableView1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! adminmealdetailsTVCell1
             selectedMealQ = cell.mealQuintity.text
            selectedMealT = cell.mealType.text
            //            cell.mealQuintity.delegate = self as? UITextFieldDelegate
            //           var meal1 = cell.mealQuintity.text
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! adminmealdetailsTVCell2
            selectedElementQ = cell.elementQuintity.text
            
            selectedElmentT =  cell.elementType.text
            return cell
        }
    }
    //    func addMeal(){
    //
    //        let elementTypeText = tableview2cell.elementType.text
    //        let elementQuintityText = tableview2cell.elementQuintity.text
    //        ref = Database.database().reference().child("meal")
    //        let mealname = mealName.text
    //
    //        let mealnamechild = ["name":mealname]
    //        let elechild = ["amount": elementQuintityText ,
    //                        "name": elementTypeText]
    //        let ingchild = ["amount": mealQuintityText ,
    //                        "name": mealTypeText]
    //        let childUpdates = ["/meal": mealnamechild,
    //                            "/meal/elements": elechild,
    //                            "/meal/ingredients": ingchild]
    //        ref.updateChildValues(childUpdates)
    //    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
