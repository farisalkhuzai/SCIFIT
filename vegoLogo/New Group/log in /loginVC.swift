//
//  loginVCViewController.swift
//  vegoLogo
//
//  Created by Faris Alkhuzai on 03/11/1439 AH.
//  Copyright © 1439 Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD



class loginVC: UIViewController, UITextFieldDelegate  {
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
    
    var ref: DatabaseReference!
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!


    // pupup2 message alert (start)
   
    /////////////////////////////////////////////////////////// (test)
    @IBAction func infoLogIn(_ sender: Any) {
        emailTextField.text = "fares111@hotmail.com"
        passTextField.text = "1234567"
    }
    @IBAction func infoLogInAdmin(_ sender: Any) {
        emailTextField.text = "admin@gmail.com"
        passTextField.text = "123456"
    }
    //////////////////////////////////////////////// (finish test)
    @IBAction func loginButton(_ sender: UIButton) {
        if emailTextField.text != "" && passTextField.text != "" {
            SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
      
       

        //        if (emailTextField.text?.isEmpty)!{
        //           self.emailError.isHidden = false
        //        }
     
        guard let userEmail = self.emailTextField.text, let userPass = self.passTextField.text else {
            return
        }
        Auth.auth().signIn(withEmail: userEmail, password: userPass) { (result, error) in
            if error != nil{
                SVProgressHUD.dismiss()
                print("log in Un seccussfull")
                self.showALert(titel: "", message: "كلمة المرور او البريد الالكتروني غير صحيح")
                
            }else{
                print("log in seccussfull")
                if Auth.auth().currentUser != nil {
                    // User is signed in.
                    // ...
                    
                    self.infocheck()
                    print(Auth.auth().currentUser?.email! as Any)
                } else {
                    // No user is signed in.
                    // ...
                }
            }
            }
        }else {
            self.showALert(titel: "تحذير !", message: "لم تدخل بيانات الحساب ")
        }
    }
    
  
    
    @IBAction func goToResetPage(_ sender: Any) {
        performSegue(withIdentifier: "resetPassword", sender: self)
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        SVProgressHUD.setDefaultMaskType(.black)
        emailTextField.delegate = self
        passTextField.delegate = self
        
        #if DEBUG
        
        emailTextField.text = "fares111@hotmail.com"
        passTextField.text = "1234567"
        
        #endif


     
//        let emailImage = UIImage(named: "mail")
//        addRightImageTo(textField: emailTextField, img: emailImage!)
//        let passImage = UIImage(named: "pass")
//        addRightImageTo(textField: passTextField, img: passImage!)
     
        // Do any additional setup after loading the view.
        
        //Looks for single or multiple taps.
        
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
     

    
    //Calls this function when the tap is recognized.
   
    }
   
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
  
    
//    func addRightImageTo(textField: UITextField , img : UIImage){
//        let rightImageView = UIImageView(frame: CGRect(x: 1, y: 1, width: 20, height: 20))
//        rightImageView.image = img
//        textField.rightView = rightImageView
//        textField.rightViewMode = .always
//
//
//    }
    
   
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func infocheck(){
        let userID = Auth.auth().currentUser!.uid
        ref = Database.database().reference().child("users").child(userID)
        ref.child("Profile").observe(.value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let age = value!["age"] as! String
            let height = value!["height"] as! String
            let name = value!["name"] as! String
            let userActivity = value!["userActivity"] as! String
            let userGoal = value!["userGoal"] as! String
            let weight = value!["weight"] as! String
            let isAdmin = value!["isAdmin"] as! String
            
            if isAdmin == "true" {
                self.performSegue(withIdentifier: "showAdmin", sender: nil)
            } else if age != "" && height != "" && name != "" && userActivity != "" && userGoal != "" && weight != "" {
                //                && height != "" && name != "" && userActivity != "" && userGoal != "" && weight != ""{
                print("details exist")
                self.performSegue(withIdentifier: "fullsignup", sender: nil)
                
            }else{
                self.performSegue(withIdentifier: "infocheck", sender: nil)
                
            }
            
            // ...
        }){ (error) in
            print(error.localizedDescription)
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
