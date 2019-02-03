//
//  customTableViewCell.swift
//  FirebaseWorkshop
//
//  Created by MISHA on 7/7/18.
//  Copyright © 2018 MISHA. All rights reserved.
//


import UIKit
extension UIColor{
    
    func colorFromHex(_ hex : String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#"){
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            return UIColor.black
        }
        
        var rgb : UInt32 = 0
        
    Scanner(string: hexString).scanHexInt32(&rgb)
        
        return UIColor.init(red :CGFloat((rgb & 0xFF0000) >> 16) / 255.0 ,
                            green :CGFloat((rgb & 0x00FF00) >> 8) / 255.0 ,
                            blue :CGFloat(rgb & 0x0000FF) / 255.0,
                            alpha : 1.0)
    }
    static let senderColor = UIColor().colorFromHex("1A3E7F")
    static let reciverColor = UIColor().colorFromHex("CF0545")
    
}


class messagesCell: UITableViewCell {
    
  
    @IBOutlet weak var rightText: UILabel!
    @IBOutlet weak var leftText: UILabel!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    @IBOutlet weak var rightDate: UILabel!
      @IBOutlet weak var leftDate: UILabel!
    static let identifire = "cell"


    override func awakeFromNib() {
       setUpDesignProperties()
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
            //  #3F51B5
            

           
        } else {
            self.leftText.text = receiverMessage
            self.leftView.backgroundColor = UIColor.reciverColor
           self.rightView.backgroundColor = UIColor.clear
            
        }
       
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
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
