//
//  RoundedButton.swift
//  vegoLogo
//
//  Created by Faris Alkhuzai on 12/11/1439 AH.
//  Copyright © 1439 Khaled Kutbi. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
