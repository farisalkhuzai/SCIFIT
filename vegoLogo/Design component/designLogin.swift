//
//  designLogin.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٧ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit

class designLogin: UITextField {
  
    self.borderStyle = UITextBorderStyle.None;
    let border = CALayer()
    let width = CGFloat(1.0)
    border.borderColor = UIColor(hexString: color)!.CGColor
    border.frame = CGRect(x: 0, y: self.frame.size.height - width,   width:  self.frame.size.width, height: self.frame.size.height)
    
    border.borderWidth = width
    self.layer.addSublayer(border)
    self.layer.masksToBounds = true
    
}
