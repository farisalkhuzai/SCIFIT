//
//  restPasswordPage.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٤ محرم، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase

class restPasswordPage: UIViewController {
    
  
    @IBOutlet weak var emailTextFaild: designTextField!
    var ref : DatabaseReference
    @IBAction func onBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func ressetPasswordBtn(_ sender: Any) {
        
        let userID = Auth.auth().currentUser!.uid
        ref = Database.database().reference().child("users").child(userID)
        ref.child("profile").observeSingleEvent(of: snapshot) { (snapshot) in
            print(snapshot)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
