
import Foundation
import UIKit
import Firebase
import SVProgressHUD





class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    var ref1:DatabaseReference!
    var name: String?
    var name1 : String?
    
    
    var currentUser = Auth.auth().currentUser!
    var databaseReference:DatabaseReference!
    
    
    //    var data: Massege?
    var data = [Massege]()
    var kbHeight: CGFloat!
    
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var heightConstraintTextMessage: NSLayoutConstraint!
   
    @IBOutlet weak var textMessage: UITextView!
    @IBOutlet weak var messagesList: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getname()
        loading.startAnimating()
        loadMessages()
        setUpDelegates()
        configureTabelView()
        SVProgressHUD.dismiss()
        let backgroundImage = UIImage(named: "scifit_wall.png")
        let imageView = UIImageView(image: backgroundImage)
        self.messagesList.backgroundView = imageView
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableviewTaped))
        messagesList.addGestureRecognizer(tapGesture)
        /////////
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
//
    }
    ///////////
    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            self.view.frame.origin.y -= keyboardSize.height
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            self.view.frame.origin.y += keyboardSize.height
//        }
//    }

  /////
    
    

    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraintTextMessage.constant = 50
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraintTextMessage.constant = 300
            self.view.layoutIfNeeded()
        }
        
    }
    
    
    @objc func tableviewTaped () {
        textMessage.endEditing(true)
    }
    
    
    func setUpDelegates() {
        messagesList.dataSource = self
        messagesList.delegate = self
        textMessage.delegate = self
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let i = (self.data.count)
            if i > 0 {
            let indexPath = IndexPath(row: i - 1 , section: 0)
            self.messagesList.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    
    //    func loadMessages() {
    //        let senderId = currentUser.uid
    //        databaseReference.child(senderId).child("Massages").observe(.value, with: { (snapshot) in
    //            if let dectionary = snapshot.value as? [String:AnyObject] {
    //                var message = Message()
    //                message.text = dectionary["text"] as? String
    //                message.senderID = dectionary["senderID"] as? String
    //
    //                self.data.append(message)
    //
    //                self.messagesList.reloadData()
    //                self.scrollToBottom()
    //            }
    //        }, withCancel: nil)
    //    }
    func loadMessages(){
        //        let userID = Auth.auth().currentUser?.uid
        let senderId = currentUser.uid
        databaseReference = Database.database().reference().child("chat")
            databaseReference.child(senderId).child("Masseges").observe(.value, with: { (snapshot) in
            
            ///let userID = "ZU7wS37XJUU6oeueYlciKWxx5X23"
            //databaseReference = Database.database().reference().child("chat")
            //databaseReference.child(senderId).child("Massages")
            
            //guard let value = snapshot.value as? [String: Any] else { return }
            //            do {
            //                // Get user value
            //                let jsonData = try JSONSerialization.data(withJSONObject: value)
            //                //                self.Diet = try! JSONDecoder().decode([DietWeeks].self, from: jsonData)
            //                self.data.append(try! JSONDecoder().decode(Massege.self, from: jsonData))
            //                self.messagesList.reloadData()
            //                self.scrollToBottom()
            //
            //
            //            } catch let error {
            //                print(error)
            //            }
            
            do {
                // Get user value
             self.data.removeAll()
                for snap in snapshot.children {
                    
                    let userSnap = snap as! DataSnapshot
                    let uid = userSnap.key //the uid of each user
                    let jsonData = try JSONSerialization.data(withJSONObject: userSnap.value)
                    self.data.append(try! JSONDecoder().decode(Massege.self, from: jsonData))
                }
                self.messagesList.reloadData()
            
                self.scrollToBottom()
                self.loading.stopAnimating()
                self.loading.isHidden = true
                self.messagesList.isHidden = false
                //print(value)
            } catch let error {
                print(error)
            }
            
            // ...
        }){ (error) in
            print(error.localizedDescription)
        }
        
    }
    //    func loadMessages(){
    //        let senderId = currentUser.uid
    //        ///let userID = "ZU7wS37XJUU6oeueYlciKWxx5X23"
    //        databaseReference.child(senderId).child("Massages").observe(.value, with: { (snapshot) in
    //            if let value = snapshot.value as? [String:AnyObject] {
    //          do {
    //
    //                    let jsonData = try JSONSerialization.data(withJSONObject: value)
    ////                    let jsonData = try JSONSerialization.data(withJSONObject: userSnap.value)
    //                    self.data.append(try! JSONDecoder().decode(Massege.self, from: jsonData))
    //            print("\(self.data)")
    //            self.messagesList.reloadData()
    //            self.scrollToBottom()
    //
    //            } catch let error {
    //                print(error)
    //            }
    //
    //            // guard let value = snapshot.value as? [String: Any] else { return }
    //            // ...
    //            }}){ (error) in
    //            print(error.localizedDescription)
    //        }
    //
    //    }
    
        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.backgroundColor = .clear
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath ) as! messagesCell
 
   
        if data[indexPath.row].senderId == currentUser.uid {
            cell.addMessage(senderMessage: data[indexPath.row].msg, receiverMessage: "")
            cell.leftDate.isHidden = true
            cell.rightDate.isHidden = false
            let dateString = data[indexPath.row].date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy HH:mm:ss"
            let newdateFormatter = DateFormatter()
            newdateFormatter.dateFormat = "MMM dd,yy HH:mm"
            if let date = dateFormatter.date(from: dateString){
               cell.rightDate.text = newdateFormatter.string(from: date)
            }

        } else {
            cell.addMessage(senderMessage: "", receiverMessage: data[indexPath.row].msg)
            cell.rightDate.isHidden = true
            cell.leftDate.isHidden = false
    
            let dateString = data[indexPath.row].date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy HH:mm:ss"
            let newdateFormatter = DateFormatter()
            newdateFormatter.dateFormat = "MMM dd,yy HH:mm"
            if let date = dateFormatter.date(from: dateString){
                cell.leftDate.text = newdateFormatter.string(from: date)
            }
         
        }
        cell.becomeFirstResponder()
        return cell
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        databaseReference = Database.database().reference().child("chat")
        let childReference = databaseReference.childByAutoId().key
        let senderId = currentUser.uid
        var mydate: String!
        mydate = dateFormatter()
        name = name1
        if textMessage.text != ""{
        let values = ["msg": textMessage.text!,
                      "date": mydate,
                      "senderId": senderId,
                      "sendername": name as Any,
                      "tokenSender": "Token",
                      "tokenReceiver": "Token"] as [String : Any]
        let childUpdates = ["/\(senderId)/Masseges/\(childReference)": values ] as [String : Any]
        databaseReference.updateChildValues(childUpdates as Any as! [AnyHashable : Any])

        
       
        self.data.removeAll()
        }
        textMessage.text = ""
    }
    @IBAction func logout(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            print("logged Out")
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("error while loggin out")
        }
    }
    
    func configureTabelView() {
        messagesList.rowHeight = UITableViewAutomaticDimension
        messagesList.estimatedRowHeight = 200.0
    }
    func getname(){
        let senderId = currentUser.uid
        ref1 = Database.database().reference().child("users").child(senderId)
        ref1.child("Profile").observe(.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let username = value!["name"] as! String
            self.name1 = username
            
        }
    }
    
    //    func textViewDidBeginEditing(_ textView: UITextView) {
    //
    //        UIView.animate(withDuration: 0.5) {
    //            self.heightConstraint.constant = 200
    //            self.view.layoutIfNeeded()
    //        }
    //    }
    //
    //    func textViewDidEndEditing(_ textView: UITextView) {
    //        UIView.animate(withDuration: 0.5) {
    //            self.heightConstraint.constant = 50
    //            self.view.layoutIfNeeded()
    //        }
    //    }
    //
  
    func dateFormatter() -> String  {
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMM dd, yyyy HH:mm:ss"
     //   let mydt = dateFormat.string(from: date).capitalized
//        var nowdate = dateFormat.string(from: date).capitalized
        
      return dateFormat.string(from: date)
    }
}
