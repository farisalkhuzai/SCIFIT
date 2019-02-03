//
//  adminChatTableCell.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢٤ صفر، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit

class adminChatTableCell: UITableViewCell {

    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftText: UILabel!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var rightText: UILabel!
    
   static let identifire = "cell"
    
    func setUpDesignProperties () {
        
        
        rightText.textColor =  UIColor.white
        leftText.textColor = UIColor.white
    }
    
    func addMessage(senderMessage: String, receiverMessage: String) {
        
        if senderMessage != "" {
            self.rightText.text = senderMessage
            self.rightView.backgroundColor = UIColor.red;           self.leftView.backgroundColor = UIColor.clear
        } else {
            self.leftText.text = receiverMessage
            self.rightView.backgroundColor = UIColor.clear
            self.leftView.backgroundColor = UIColor.gray
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpDesignProperties()
    }
 

}

