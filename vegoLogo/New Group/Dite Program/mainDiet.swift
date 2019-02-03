//
//  mainDiet.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٤ صفر، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit






class mainDiet: UIViewController {

    
    @IBOutlet weak var dayView: UIView!
    @IBOutlet weak var weekView: UIView!
    @IBOutlet weak var monthView: UIView!
    
    @IBOutlet weak var dayTableConstrain: NSLayoutConstraint!
    @IBOutlet weak var weekTableConstrain: NSLayoutConstraint!
    @IBOutlet weak var monthTableConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var dayButton: UIButton!
    
    var selectedMonthBorder = CALayer()
    var selectedWeekBorder = CALayer()
    var selectedDayBorder = CALayer()
    
    @IBAction func monthButton(_ sender: Any) {
        //////
        let border = CALayer()
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 2, y: monthButton.frame.size.height - 2.0, width:  monthButton.frame.size.width - 5, height: monthButton.frame.size.height)
        
        border.borderWidth = 3.0
        monthButton.layer.addSublayer(border)
        monthButton.layer.masksToBounds = true
        selectedMonthBorder = border
        selectedDayBorder.isHidden = true
        selectedWeekBorder.isHidden = true
       
        self.monthTableConstrain.constant = 0
        UIView.animate(withDuration: 0.6, animations: {
            self.view.layoutIfNeeded()
        })
        
        
    }
    @IBAction func weekButton(_ sender: Any) {
        let border = CALayer()
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 2, y: weekButton.frame.size.height - 2.0, width:  weekButton.frame.size.width - 5, height: weekButton.frame.size.height)
        
        border.borderWidth = 3.0
        weekButton.layer.addSublayer(border)
        weekButton.layer.masksToBounds = true
        selectedWeekBorder = border
        selectedDayBorder.isHidden = true
        selectedMonthBorder.isHidden = true
        
         monthView.isHidden = true
        
        self.dayTableConstrain.constant = 360
        UIView.animate(withDuration: 0.6, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.monthTableConstrain.constant = 360
        UIView.animate(withDuration: 0.6, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.weekTableConstrain.constant = 0
        UIView.animate(withDuration: 0.6, animations: {
            self.view.layoutIfNeeded()
            })
       
       
    }
    @IBAction func dayButton(_ sender: Any) {
        let border = CALayer()
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 2, y: dayButton.frame.size.height - 2.0, width:  dayButton.frame.size.width - 5, height: dayButton.frame.size.height)
        
        border.borderWidth = 3.0
        dayButton.layer.addSublayer(border)
        dayButton.layer.masksToBounds = true
        selectedDayBorder = border
        selectedMonthBorder.isHidden = true
        selectedWeekBorder.isHidden = true
        
        monthView.isHidden = true
        
        
        self.weekTableConstrain.constant = 360
        UIView.animate(withDuration: 0.6, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.monthTableConstrain.constant = 360
        UIView.animate(withDuration: 0.6, animations: {
            self.view.layoutIfNeeded()
        })
        
        self.dayTableConstrain.constant = 0
        UIView.animate(withDuration: 0.6, animations: {
            self.view.layoutIfNeeded()
        })
       
       
     
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 

}
