//
//  adminChatVC.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢٢ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD


class adminChatVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var messagesTable: UITableView!
    
    @IBOutlet weak var textMessage: UITextView!
    
    
    
    var ref1:DatabaseReference!
    var name: String?
    var name1 : String?
    var username : String?
    var currentUser = Auth.auth().currentUser!
    var databaseReference:DatabaseReference!
    //    let databaseReference = Database.database().reference().child("chat")
    //    var data: Massege?
    var data = [Massege]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getname()
        
        loadMessages()
        setUpDelegates()
        configureTabelView()
        SVProgressHUD.dismiss()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableviewTaped))
        messagesTable.addGestureRecognizer(tapGesture)
        
    }
    
    
    func setUpDelegates() {
        messagesTable.dataSource = self
       messagesTable.delegate = self
        textMessage.delegate = self
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            var i = (self.data.count)
            let indexPath = IndexPath(row: i - 1, section: 0)
            self.messagesTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
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
        let refChat = Database.database().reference().child("chat").child(senderId).child("Masseges").observe(.value, with: { (snapshot) in
            
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
                
                for snap in snapshot.children {
                    
                    let userSnap = snap as! DataSnapshot
                    let uid = userSnap.key //the uid of each user
                    let jsonData = try JSONSerialization.data(withJSONObject: userSnap.value)
                    self.data.append(try! JSONDecoder().decode(Massege.self, from: jsonData))
                }
                self.messagesTable.reloadData()
                self.scrollToBottom()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as! messagesCell
        //        let message = data[indexPath.row]
        
        //        if message.senderID == currentUser.uid {
        //            cell.addMessage(senderMessage: message.text!, receiverMessage: "")
        //        } else {
        //            cell.addMessage(senderMessage: "", receiverMessage: message.text!)
        //        }
        //        cell.leftText.text = data[indexPath.row].msg
        if data[indexPath.row].senderId == currentUser.uid {
            cell.addMessage(senderMessage: data[indexPath.row].msg, receiverMessage: "")
        } else {
            cell.addMessage(senderMessage: "", receiverMessage: data[indexPath.row].msg)
        }
        return cell
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
        databaseReference = Database.database().reference().child("chat")
        let childReference = databaseReference.childByAutoId().key
        let senderId = currentUser.uid
        
        name = name1
        let values = ["msg": textMessage.text!,
                      "date": String(),
                      "senderId": senderId,
                      "sendername": name as Any,
                      "tokenSender": "Token",
                      "tokenReceiver": "Token"] as [String : Any]
        let childUpdates = ["/\(senderId)/Masseges/\(childReference)": values ] as [String : Any]
        databaseReference.updateChildValues(childUpdates as Any as! [AnyHashable : Any])
        self.data.removeAll()
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
        messagesTable.rowHeight = UITableViewAutomaticDimension
        messagesTable.estimatedRowHeight = 200.0
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
    @objc func tableviewTaped () {
        textMessage.endEditing(true)
    }
    
    
}
