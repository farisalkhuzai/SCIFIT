//
//  sideMenu.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢٤ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class sideMenu: UIViewController {

    @IBAction func myInfoButton(_ sender: Any) {
        performSegue(withIdentifier: "info", sender: nil)
    }
    @IBAction func logOutButton(_ sender: Any) {
        
        
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            try! GIDSignIn.sharedInstance()?.signOut()
            performSegue(withIdentifier: "signIn", sender: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "info" {
            //personalinfo
//
            let vc = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "personalinfo") as! personalInfoViewController

            self.present(vc, animated:true, completion:nil)
            
    
        }
        else{
            let vc2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            self.present(vc2, animated:true, completion:nil)
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
}
