//
//  design.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢٠ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import Foundation
import UIKit



class designView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 100

    @IBInspectable var cornerRedius: CGFloat = 0.0 {
        
        didSet{
            self.layer.cornerRadius =   cornerRadius
        }
    }
    
}

class designTextView: UITextView {
    
    @IBInspectable var cornerRadius: CGFloat = 100
    
    @IBInspectable var cornerRedius: CGFloat = 0.0 {
        
        didSet{
            self.layer.cornerRadius =   cornerRadius
        }
    }
    
}

class designLable : UILabel {
    
    @IBInspectable let shadow: UIColor = UIColor.black
    @IBInspectable let shadowOffSetWidth : Int = 0
    @IBInspectable let shadowOffSetHeight : Int = 1
    @IBInspectable var shadowOpacity : Float = 0.2
    @IBInspectable var cornerRadius: CGFloat = 100
    
    @IBInspectable var cornerRedius: CGFloat = 0.0 {
        
        didSet{
            self.layer.cornerRadius =   cornerRadius
        }
    
    }
   
}
class topBorderDesignLabel : UILabel {
    @IBInspectable var blockColor: UIColor = UIColor.black {
        
        didSet{
            
            let border = CALayer()
     
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 1)
            border.backgroundColor = blockColor.cgColor;
            
            self.layer.addSublayer(border)
        }
    }
    
   
}

class designViewOfZoomImage : UIView {
    
    @IBInspectable var blockColor: UIColor = UIColor.lightGray {
        
        didSet{
            
            let border = CALayer()
            //top
            border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 2)
            // left
            border.frame = CGRect(x: 0, y: 0, width: 1, height: self.frame.height)
            //bottom
            border.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
            //right
            border.frame = CGRect(x: self.frame.width - 1, y: 0, width: 1, height: self.frame.height)
            border.backgroundColor = blockColor.cgColor;

            self.layer.addSublayer(border)
        }
    }
    
   
}


class designButton : UIButton {
    @IBInspectable var cornerRadius: CGFloat = 100
    @IBInspectable var cornerRedius: CGFloat = 0.0{
        
        didSet{
            self.layer.cornerRadius = cornerRadius
            
        }
    }
    
}
class designTableView : UITableView {
    @IBInspectable var cornerRadius: CGFloat = 100
    @IBInspectable var cornerRedius: CGFloat = 0.0{
        
        didSet{
            self.layer.cornerRadius = cornerRadius
            
        }
    }
    
}
class designImage : UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 100
    @IBInspectable var cornerRedius: CGFloat = 0.0{
        
        didSet{
            self.layer.cornerRadius = cornerRadius
            
        }
    }
    
}
class designTextField : UITextField {
    
    
    
    @IBInspectable var cornerRadius: CGFloat = 100
    @IBInspectable var cornerRedius: CGFloat = 0.0{
        
        didSet{
            self.layer.cornerRadius = cornerRadius
            
        }
    }
    
}
