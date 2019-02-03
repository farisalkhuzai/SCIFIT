//
//  resetPassword.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٤ محرم، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase

class resetPassword: UIViewController,UITextFieldDelegate {
    
    var ref : DatabaseReference!
    var usersEmail : User?
    
    
    
    @IBOutlet weak var emailTextfeild: designTextField!
    
    @IBAction func onBack(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func restPasswordBtn(_ sender: Any) {
        if (emailTextfeild.text == nil){
            
            //show to him  pupup meassge
        }else{
        Auth.auth().sendPasswordReset(withEmail: emailTextfeild.text!) {
            error in
            if let error = error{
                print(error)
            }else {
                print("password Reset email sent.")
                showALert(titel: "", message: "تم ارسال رسالة الي البريد الالكتروني الخاص بك بنجاح لاعادة تعيين كلمة مرور جديدة ")
                self.emailTextfeild.text = ""
            }
            
            
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
    }
    override func viewDidLoad() {
        super.viewDidLoad()
      emailTextfeild.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
