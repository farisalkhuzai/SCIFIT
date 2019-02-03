//
//  adminChatTablCell.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢٤ صفر، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit




class adminChatTablCell: UITableViewCell {
    
    
static let identifire = "cell"
    
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftText: UILabel!
    @IBOutlet weak var leftDate: UILabel!
    
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var rightText: UILabel!
    @IBOutlet weak var rightDate: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        rightText.numberOfLines = 0
        rightText .preferredMaxLayoutWidth = 340
        rightText .lineBreakMode = NSLineBreakMode.byWordWrapping
        rightText .sizeToFit()
        
        leftText.numberOfLines = 0
        leftText .preferredMaxLayoutWidth = 340
        leftText.lineBreakMode = NSLineBreakMode.byWordWrapping
        leftText.sizeToFit()
    }
    
    
    
    
    
    func setUpDesignProperties () {
        
        
        rightText.textColor =  UIColor.white
        leftText.textColor = UIColor.white
    }
    
    
    func addMessage(senderMessage: String, receiverMessage: String) {
        
        if senderMessage != "" {
            self.rightText.text = senderMessage
            self.rightView.backgroundColor = UIColor.senderColor
            self.leftView.backgroundColor = UIColor.clear
        } else {
            self.leftText.text = receiverMessage
            self.rightView.backgroundColor = UIColor.clear
            self.leftView.backgroundColor = UIColor.reciverColor
        }
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        leftText.text = nil
        leftDate.text = nil
       // leftText.textColor  = UIColor.clear
        leftView.backgroundColor = UIColor.clear
        rightText.text = nil
        rightDate.text = nil
       // rightText.textColor  = UIColor.clear
        rightView.backgroundColor = UIColor.clear
    }
}
