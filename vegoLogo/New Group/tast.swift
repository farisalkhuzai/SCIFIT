//
//  tast.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢ محرم، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit

class tast: UIViewController {

    
    @IBOutlet weak var circelImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    circelImage.layer.cornerRadius = circelImage.frame.size.width/2
        circelImage.clipsToBounds = true 
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
