//
//  test.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٤ صفر، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit

class test: UIViewController {

    
    @IBOutlet weak var label1: UILabel!
    
    var showView: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
      
        if showView{
            label1.text = "i love you"
        }
       
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
