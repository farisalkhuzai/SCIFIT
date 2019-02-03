//
//  addNewExAdmin.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٩ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//


import UIKit
import Firebase
import FirebaseStorage
import CodableFirebase
import SwiftGifOrigin
class addNewExAdmin: UIViewController ,UIPickerViewDelegate , UIPickerViewDataSource , UITextFieldDelegate ,UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imgURL:String! = nil
    var exercise: ExerciesValue?
    var ref:DatabaseReference!
    var exerciseplace: String!
    @IBOutlet weak var exersiceImage: UIImageView!
    @IBOutlet weak var exersiceNameTf: UITextField!
    @IBOutlet weak var exersiceCountTf: UITextField!
  
    
    @IBAction func addFreeExerSwitch(_ sender: UISwitch) {
        if (sender.isOn == true){
            //            let uid = Auth.auth().currentUser?.uid
            //            ref = Database.database().reference().child("users").child(uid!)
            exerciseplace = "exerciesForALL"

        } else {
            exerciseplace = "exercies"
        }
        
        //TODO by fares 
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    let imagePicker = UIImagePickerController()
    //    var exersiceNamePickerView = UIPickerView()
    var exersiceCountPickerView = UIPickerView()
    //    var selectedExersiceName : String?
    var selectedExersiceCount : String?
    //    var exersiceNameArray = ["kjh;lk","sdf","dfg" ]
    var exersiceCountArray = ["صدر","بطن","تراي","باي","ظهر","سواعد","رجول","بطات","كور"]
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
        
        let storeRef = store.reference().child("exercises/ \(randomString(2))")
        
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
            self.exersiceImage.image = profileImageFromPicker
        }
        
        
        
    }
    func refreshExerciseImage(){
        
        let store = Storage.storage()
        let storeRef = store.reference().child("exercises/ \(randomString(2))")
        
        storeRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else {
                let image = UIImage.gif(data: data!)
                self.exersiceImage.image = image
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
    @IBAction func addexeimg(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //        if (pickerView.tag == 1){
        //            return exersiceNameArray.count
        //        } else{
        return exersiceCountArray.count
        //        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //        if(pickerView.tag == 1){
        //            return exersiceNameArray[row]
        //        }else {
        return exersiceCountArray[row]
        
        //        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        if (pickerView.tag == 1){
        //            selectedExersiceName = exersiceNameArray[row]
        //            exersiceNameTf.text = selectedExersiceName
        
        //        }else{
        selectedExersiceCount = exersiceCountArray[row]
        exersiceCountTf.text = selectedExersiceCount
        
        //        }
        
    }
    
    func designPieckerTextField(){
        //creat tool bar in picker
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        // creat done button
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(daiteAdmin.donePressed))
        
        
        toolBar.setItems([doneButton], animated: true)
        
        
        // creat picker for every text field
        //        exersiceNameTf.inputView = exersiceNamePickerView
        //        exersiceNameTf.inputAccessoryView = toolBar
        
        exersiceCountTf.inputView = exersiceCountPickerView
        exersiceCountTf.inputAccessoryView = toolBar
        
        
    }
    @objc func donePressed(_ sender: UIBarButtonItem) {
        
        //        exersiceNameTf.resignFirstResponder()
        exersiceCountTf.resignFirstResponder()
        
        
    }
    func showALert(titel : String , message: String){
        let alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addButton(_ sender: Any) {
        if (exersiceNameTf.text != ""){
            
            
        print(imgURL)
        append()
            
        }else {
            self.showALert(titel: "", message: "لم تدخل بيانات التمرين الجديد !")
        }
        //        let profileImageFromPicker = Info[UIImagePickerControllerOriginalImage] as! UIImage
        //
        //        let metadata = StorageMetadata()
        //        metadata.contentType = "image/gif"
        //
        //        let imageData: Data = UIImageJPEGRepresentation(profileImageFromPicker, 0.5)!
        //
        //        let store = Storage.storage()
        //
        //        let storeRef = store.reference().child("exercises/ \(randomString(1))")
        //
        //        let _ = storeRef.putData(imageData, metadata: metadata) { (metadata, error) in
        //
        //            guard let _ = metadata else {
        //                print("error occurred: \(error.debugDescription)")
        //                return
        //            }
        //
        //            self.exersiceImage.image = profileImageFromPicker
        //        }
        
        
        //        if let uploadImage = UIImagePNGRepresentation(self.exersiceImage.image!){
        //            st
        //        }
        
        
    }
    func append(){
        ref = Database.database().reference()
        
        
        
        //            ingredients[i].name = cell.
        //            ingredients[i].amount = Double(cell.mealQuintity.text)!
        
        //
        
        exercise = ExerciesValue(exername: exersiceNameTf.text!, image: imgURL, targetedmuscle: self.selectedExersiceCount!)
        if exerciseplace == "exercies" {
//            ref.child("exercies").observe(.value, with: { snapshot in
            ref.child("exercies").observeSingleEvent(of: .value, with:{ snapshot in
                //            let i = snapshot.childrenCount
                let data = try! FirebaseEncoder().encode(self.exercise)
                self.ref.child("exercies").child("\(snapshot.childrenCount)").updateChildValues(data as! [AnyHashable : Any])
            })

            
            
        }else{
            
            ref = Database.database().reference().child("exerciesForALL")
            ref.observeSingleEvent(of: .value, with:{ snapshot in
//            ref.observe(.value, with: { snapshot in
                //            let i = snapshot.childrenCount
                let sets = ["reps": "1234"
                    ,"rm1": String()
                    ,"weight": String()
                    ,"volume": String()]
                let setchild = ["0":sets]
                let dayexercisechild = ["exername":self.exersiceNameTf.text!
                    ,"image": self.imgURL
                    ,"targetedmuscle":self.selectedExersiceCount
                    ,"sets":setchild] as [String : Any]
               
               
                self.ref.child("\(snapshot.childrenCount)").updateChildValues(dayexercisechild as! [AnyHashable : Any])
            })
           

        
        
        }
        
//        ref.child("exercies").observe(.value, with: { snapshot in
//            //            let i = snapshot.childrenCount
//            let data = try! FirebaseEncoder().encode(self.exercise)
//            self.ref.child("exercies").child("\(snapshot.childrenCount)").updateChildValues(data as! [AnyHashable : Any])
//        })

        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        self.refreshExerciseImage()
        //        exersiceNamePickerView.tag = 1
        exersiceCountPickerView.tag = 2
        
        //        exersiceNamePickerView.delegate = self
        //        exersiceNamePickerView.dataSource = self
        exersiceNameTf.delegate = self
        
        exersiceCountPickerView.delegate = self
        exersiceCountPickerView.dataSource = self
        exersiceCountTf.delegate = self
        
        
        designPieckerTextField()
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        if CheckInternet.Connection() {
            
            print("internet is connected ")
            
        }else {
            self.showALert(titel: "تنبيه ! ", message: "الاتصال بالنترنت ضعيف او مقطوع ")
            print("internet is not connected ")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
