//
//  CellView.swift
//  vegoLogo
//
//  Created by Faris Alkhuzai on 06/11/1439 AH.
//  Copyright © 1439 Khaled Kutbi. All rights reserved.
//
import Foundation
import UIKit

class CellView: UIView {
    @IBInspectable var cornerRadius : CGFloat = 10
    @IBInspectable var shadowColor : UIColor? = UIColor.gray
    @IBInspectable var shadowOffSetWidth : Int = 5
    @IBInspectable var shadowOffSetHeight: Int = 5
    @IBInspectable var shadowOpacity : Float = 0.5
    
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
