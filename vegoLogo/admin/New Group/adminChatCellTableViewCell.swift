


import UIKit

class adminChatCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var rightText: UILabel!
    @IBOutlet weak var leftText: UILabel!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    static let identifire = "cell"
    
    override func awakeFromNib() {
        setUpDesignProperties()
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpDesignProperties () {
        
        
        rightText.textColor =  UIColor.white
        leftText.textColor = UIColor.white
    }
    
    
    
    
    
//    
//    func addMessage(senderMessage: String, receiverMessage: String) {
//        
//        if senderMessage != "" {
//            self.rightText.text = senderMessage
//            self.rightView.backgroundColor = UIColor.red            self.leftView.backgroundColor = UIColor.clear
//        } else {
//       
//            
//            
//            
//            
//            self.leftText.text = receiverMessage
//
//            
//            
//            self.rightView.backgroundColor = UIColor.clear
//            
//            self.leftView.backgroundColor = UIColor.gray
//        }
//    }
//        
    
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

