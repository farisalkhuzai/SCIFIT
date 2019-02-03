//
//  supportAdmin.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢٢ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


var currentUserchatId = String()

class supportAdmin: UIViewController ,  UITableViewDelegate, UITableViewDataSource{
 
    
    @IBOutlet weak var usersTV: UITableView!
    var users = [User]()
    var users1 = [User]()
    var ref:DatabaseReference!
//    var selectedUsername: Profile?
    var username: String!
    var userid:String!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! supportCell
        cell.emailOfUser.text = users[indexPath.row].profile.userEmail
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.username = users[indexPath.row].profile.name
        self.userid = users[indexPath.row].profile.uid
        self.performSegue(withIdentifier: "seguechat", sender: nil)
    }
    
    func getUserNsme(){
        ref.child("users").observe(.value, with: { (snapshot) in

            do {
                // Get user value

                for snap in snapshot.children {
                    let userSnap = snap as! DataSnapshot
                    let uid = userSnap.key //the uid of each user
                    let jsonData = try JSONSerialization.data(withJSONObject: userSnap.value)
                    self.users.append(try! JSONDecoder().decode(User.self, from: jsonData))
                }
                self.usersTV.reloadData()
                //print(value)
            } catch let error {
                print(error)
            }

            // guard let value = snapshot.value as? [String: Any] else { return }
            // ...
        }){ (error) in
            print(error.localizedDescription)
        }


    }
//    func getUserNsme(){
//        ref.child("users").observe(.value, with: { (snapshot) in
//
//            do {
//                // Get user value
//
//                for snap in snapshot.children {
//                    let userSnap = snap as! DataSnapshot
//                    let uid = userSnap.key //the uid of each user
//                    self.ref.child("chat").observe(.value, with: { (DataSnapshot) in
//                       do {
//                        for snap in DataSnapshot.children {
//                            if DataSnapshot.hasChild(uid){
//                                let jsonData = try JSONSerialization.data(withJSONObject: userSnap.value)
//                                self.users.append(try! JSONDecoder().decode(User.self, from: jsonData))
//                            }
//                        }
//                       } catch let error {
//                        print(error)
//                        }
//                    })
//               { (error) in
//                        print(error.localizedDescription)
//                    }
//                }
//                self.usersTV.reloadData()
//                //print(value)
//            } catch let error {
//                print(error)
//            }
//
//            // guard let value = snapshot.value as? [String: Any] else { return }
//            // ...
//        }){ (error) in
//            print(error.localizedDescription)
//        }
//
//
//    }

    func showALert(titel : String , message: String){
        let alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        if CheckInternet.Connection() {
            
            print("internet is connected ")
            
        }else {
            self.showALert(titel: "تنبيه ! ", message: "الاتصال بالنترنت ضعيف او مقطوع ")
            print("internet is not connected ")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
         getUserNsme()
        usersTV.delegate = self
        usersTV.dataSource = self
        self.usersTV.separatorStyle = UITableViewCellSeparatorStyle.none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguechat"  {
            if let destinationVC = segue.destination as? adminChat {
              destinationVC.username = self.username
            destinationVC.selecteduid = self.userid
            
            }
        }
    }

    
   
    }


