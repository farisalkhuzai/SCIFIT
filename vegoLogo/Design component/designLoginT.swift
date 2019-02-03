//
//  designLoginT.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٧ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Foundation

class designLoginT: UITextField {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        underlineView.backgroundColor = UIColor.lightGray
        
        // Highlight/unhighlight the underlined view when it's being edited.
        reactive.controlEvents(.editingDidBegin).map { _ in
            return UIColor.green
            }.bind(to: underlineView.reactive.backgroundColor).dispose(in: reactive.bag)
        
        reactive.controlEvents(.editingDidEnd).map { _ in
            return UIColor.lightGray
            }.bind(to: underlineView.reactive.backgroundColor).dispose(in: reactive.bag)
    }
    
    
    
    
    
}
