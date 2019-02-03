//
//  signupVC.swift
//  vegoLogo
//
//  Created by Faris Alkhuzai on 03/11/1439 AH.
//  Copyright © 1439 Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import SVProgressHUD


class signupVC: UIViewController , UITextFieldDelegate, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate {
    
    
    var ref: DatabaseReference!
    var profile: Profile?
    var diet: Diet?
    var userEmail:String!
    var users = [User]()
    var user: User?
    var selectedGoogleID : String?
    var selectedGoogleEmail: String?
  
    // Text Field sign up
    
    //    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var mailView: UIView!
    @IBOutlet weak var passView: UIView!
    @IBOutlet weak var confirmPassView: UIView!
    //    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confairmPasswordTextField: UITextField!
   
  
   
  

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
        //        self.nameView.bottomBorderVSignup()
       
        // isValidEmail(email: emailTextField.text)
         SVProgressHUD.setDefaultMaskType(.black)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        confairmPasswordTextField .delegate = self
        //////handling google login ///////////
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
//        ////design google button
//        let googleButton = GIDSignInButton()
//        view.addSubview(googleButton)
//        googleButton.frame = CGRect(x: 30, y: 70, width: view.frame.width - 30, height: 43)
        // design facebook button
//        let facebookButton = FBSDKLoginButton()
//        view.addSubview(facebookButton)
//        facebookButton.frame = CGRect(x: 16, y: 50, width: view.frame.width - 40, height: 43)
//        facebookButton.delegate = self
        
       
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
       
        // ...
        if let error = error {
            print(error.localizedDescription)
            return
        }
        print("sign in google done")
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                
                print(error.localizedDescription)
                return
            }
            let userID = Auth.auth().currentUser?.uid
            self.selectedGoogleID = user.userID
            self.selectedGoogleEmail = user.profile.email
//            self.addUser(userUID: userID!, userEmail: self.selectedGoogleEmail!)
            print("signed in firebase done ")
//            self.infocheck()
            self.checkGoogleAccount()
          
            //self.performSegue(withIdentifier: "info", sender: nil)
            // self.addUser(userUID: user.userID, userEmail: user.profile.email)

        }
        
    }
    
    
    func checkGoogleAccount(){
        ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
//        ref.child("users").observe(.value, with: { (snapshot) in
            do {
                if snapshot.hasChild(userID!){
                    
                    self.infocheck()
                    
                    
                }else{
                    self.addUser(userUID: userID!, userEmail: self.selectedGoogleEmail!)
                    self.performSegue(withIdentifier: "info", sender: nil)
                    print("false room doesn't exist")
                }
//                for snap in snapshot.children {
//                    let excersSnap = snap as! DataSnapshot
//                    let jsonData = try JSONSerialization.data(withJSONObject: excersSnap.value)
//                    self.users.append(try! JSONDecoder().decode(User.self, from: jsonData))
//
//                }
//                let int = self.users.count
//                for i in 0..<int{
////                let StringUid = "BVI0hAYTGHcSU5whE9EpMJkn4XB3"
//                let userID = Auth.auth().currentUser?.uid
//                    if (userID == self.users[i].profile.uid){
////                if (userID == /*self.user?.profile.uid*/StringUid){
//                    self.infocheck()
////                    self.performSegue(withIdentifier: "fullsignup", sender: nil)
//                }else {
//
////                    self.addUser(userUID: userID!, userEmail: self.selectedGoogleEmail!)
////                    self.addUser(userUID: self.selectedGoogleID!, userEmail: self.selectedGoogleEmail!)
////                     self.infocheck()
//                    self.performSegue(withIdentifier: "info", sender: nil)
//                }
//                }
                print("\(self.users)")
            } catch let error {
                print(error)
            }
        }){ (error) in
            print(error.localizedDescription)
        }
        
    }
    

    @IBAction func BackToLogIn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //////// google accont sign in
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
           
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
   
    
    //////////// facebook account sign in ///////////
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error.localizedDescription )
            return
        }
       print("Facebook sign in successfully")
        guard let authenticationToken = FBSDKAccessToken.current()?.tokenString else {return}
        let credential = FacebookAuthProvider.credential(withAccessToken:authenticationToken)
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("sign in firebase successfully ")
            }
    
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did Log out from facebook account ")
    }
    //////////////////////////////////////////////////
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func signupButoon(_ sender: UIButton) {
        
         SVProgressHUD.show()
        let emailvalid = isValidEmail(email: emailTextField.text!)
        let passvalid = isValidPassword(password: passwordTextField.text!)
        ref = Database.database().reference()
        if emailvalid == false{
            //email alert
            print("email is not valid")
            SVProgressHUD.dismiss()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                
            }
            //        }
            //            else if passvalid == false{
            //            //password alert
            //            print("password s not valid")
        }else if self.passwordTextField.text != self.confairmPasswordTextField.text{
            //pass and confairmpass not the same
            print("password and confairm password is not the same")
            SVProgressHUD.dismiss()
            
            
        }else{
            //            if emailvalid == false && passvalid == false && self.passwordTextField.text == self.confairmPasswordTextField.text{
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
                if error != nil  {
                    print(error!)
                }else {
                    if let userID = Auth.auth().currentUser?.uid {
                        self.userEmail = self.emailTextField.text
                        self.addUser(userUID: userID, userEmail: self.userEmail)
                        self.performSegue(withIdentifier: "info", sender: nil)
                        print ("Registration Successful!")
                        
                        
                    }
                    
                }
                
            })
        }
        // Store data
        
        // display messag e confermation
          func checkInfoGoogleAccount(){
            
            ref = Database.database().reference().child("users").child(selectedGoogleID!)
            ref.child("profile").observe(.value, with: {(snapshot) in
                let value = snapshot.value as? NSDictionary
                let age = value!["age"] as! String
                let height = value!["height"] as! String
                let name = value!["name"] as! String
                let userActivity = value!["userActivity"] as! String
                let userGoal = value!["userGoal"] as! String
                let weight = value!["weight"] as! String
                
                if age == nil || height == nil || weight == nil || name == nil || userActivity == nil || userGoal == nil {
                    print("you have to enter your information")
                }else {
                    self.performSegue(withIdentifier: "fullsignup", sender: nil)
                }
                
                
            })
            
        }
        
        
    }
    func addUser(userUID:String, userEmail:String){
        
        ref = Database.database().reference().child("users")
        //        let key = ref.child("users").childByAutoId().key
        let key = ref.child(userUID).key
        
        //        let post = ["uid": userID]
        //        let post = "\(key)"
        let profilechild = ["adminBrief" : String(),
                            "age": String(),
                            "height": String(),
                            "isAdmin":"false",
                            "name": String(),
                            "previousWeight": String(),
                            "uid": userUID,
                            "userActivity": String(),
                            "userEmail": userEmail,
                            "userGoal": String(),
                            "weight": String()
            
            
        ]
        //             let post = ["age": String(), "day": String()]
        
        Logger.normal(tag: "uid", message: userUID)
        
        let ingredientschild = ["quantity": String()
            ,"type": String()]
        
        let ingredients = ["0": ingredientschild]
        
        let elementchild = ["amount": String()
            ,"name":String()]
        
        let element = ["0": elementchild]
        
        let daymealschild = ["cal": String()
            ,"elements":element
            ,"image": String()
            ,"ingredients": ingredients
            ,"name": String()] as [String : Any]
        
        let daymeals = ["0": daymealschild]
        
        let daylymeals = ["day": String()
            ,"dayMeals": daymeals
            ,"mealsCount": String()
            ,"totalCals": String()] as [String : Any]
        
        let dietchild = ["0": daylymeals,
                         "1": daylymeals,
                         "2": daylymeals,
                         "3": daylymeals,
                         "4": daylymeals,
                         "5": daylymeals,
                         "6": daylymeals]
        let dietweeks = ["week1":dietchild,
                         "week2":dietchild,
                         "week3":dietchild,
                         "week4":dietchild]
        let dietmonth = ["0": dietweeks,
                         "1": dietweeks,
                         "2": dietweeks,
                         "3": dietweeks]
        let sets = ["reps": String()
            ,"rm1": String()
            ,"weight": String()
            
            ,"volume": String()]
        let setchild = ["0":sets]
        let dayexercisechild = ["exername":String()
            ,"image": String()
            ,"targetedmuscle":String()
            ,"sets":setchild] as [String : Any]
        
        let exechild = ["0":dayexercisechild]
        
        let dayexe = ["day": String()
            ,"exercise":exechild
            ,"targetedmuscles":String()
            ,"exercisecount": String()] as [String : Any]
        //        let exersicechild = ["0":dayexe] as [String : Any] as [String : Any]
        let exersicechild =    ["0": dayexe,
                                "1": dayexe,
                                "2": dayexe,
                                "3": dayexe,
                                "4": dayexe,
                                "5": dayexe,
                                "6": dayexe]
        let exerweeks = ["week1":exersicechild,
                         "week2":exersicechild,
                         "week3":exersicechild,
                         "week4":exersicechild]
        let exermonth = ["0": exerweeks,
                         "1": exerweeks,
                         "2": exerweeks,
                         "3": exerweeks]
        let childUpdates = ["/\(key)/Diet": dietmonth,"/\(key)/Profile": profilechild,"/\(key)/Exercises": exermonth ] as [String : Any]
        
        
        
        
        
        ref.updateChildValues(childUpdates as Any as! [AnyHashable : Any])
        
        
    }
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z].*[a-z].*[a-z])(?=.*[A-Za-z0-9])[A-Za-z0-9]{8,16}"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        let result = passwordTest.evaluate(with: password)
        return result
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
                        if age != "" && height != "" && name != "" && userActivity != "" && userGoal != "" && weight != ""{
            
            
                print("details exist")
                self.performSegue(withIdentifier: "fullsignup", sender: nil)
                        }else{
                            self.performSegue(withIdentifier: "info", sender: nil)
            }
            
            
            // ...
        }){ (error) in
            print(error.localizedDescription)
            
        }
        
    }
}
