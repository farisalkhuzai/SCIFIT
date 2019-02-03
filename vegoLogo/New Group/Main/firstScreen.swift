//
//  firstScreen.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on 08/03/1440 AH.
//  Copyright © 1440 Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase

class firstScreen: UIViewController {

     var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "alredySignedIn", sender: nil )
            
        } else {
            performSegue(withIdentifier: "loginScreen ", sender: nil)
        }
    }
}
