//
//  freeExercisesTable.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on 04/03/1440 AH.
//  Copyright © 1440 Khaled Kutbi. All rights reserved.
//
import UIKit
import Firebase

class freeExercisesTable: UIViewController , UITableViewDelegate , UITableViewDataSource{
    
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var moucelLabel: UILabel!
    
    @IBOutlet weak var ExercisesTableView: UITableView!
    var ref:DatabaseReference!
    var freeExercises = [ExerciseElement]()
    var exerciseInfo : ExerciseElement?
    var nameOfmucle : String!
    
    var selectedFreeExercisetargtedMoucle: String?
    var selectedFreeExerciseName : String?
    var selectedFreeExerciseImage : String?
    var selectedFreeExerciseSets : Set?
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if CheckInternet.Connection() {
            
            print("internet is connected ")
            
        }else {
            self.showALert(titel: "تنبيه ! ", message: "الاتصال بالنترنت ضعيف او مقطوع ")
            print("internet is not connected ")
        }
    }
    func showALert(titel : String , message: String){
        let alert = UIAlertController(title: titel, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler:{ (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loading.startAnimating()
        //test()
        ExercisesTableView.delegate = self
        ExercisesTableView.dataSource = self
        //        ExercisesTableView.reloadData()
        loadFreeExercise()
        moucelLabel.text = nameOfmucle
         self.ExercisesTableView.separatorStyle = UITableViewCellSeparatorStyle.none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return freeExercises.count
    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ExercisesTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! freeExercisesTableCell
        ////need to fill the location of component in the next view controller
        cell.nameOfExercise.text = freeExercises[indexPath.row].exername
        cell.nameOfMucle.text = freeExercises[indexPath.row].targetedmuscle
        // cell.exerciseImage.image
        
        
        do{
            let imgURL = freeExercises[indexPath.row].image
            //            let imgURL = self.exercise[indexPath.row].image
            let url = URL(string: imgURL)
            //            let url = URL(string: "https://firebasestorage.googleapis.com/v0/b/vego-6.appspot.com/o/exercises%2F2?alt=media&token=b90ad507-4a4c-447a-97d4-6ea05e2265d8")
            let data = try Data(contentsOf: url!)
            //            let gif = UIImage.gifI
            cell.exerciseImage.image = UIImage(data: data)
            //            self.exerciseimg.image = UIImage(data: data)
        }
        catch{
            print(error)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedFreeExercisetargtedMoucle = freeExercises[indexPath.row].targetedmuscle
        self.selectedFreeExerciseName = freeExercises[indexPath.row].exername
        self.selectedFreeExerciseImage = freeExercises[indexPath.row].image
        //self.selectedFreeExerciseSets = freeExercises[indexPath.row].sets.
        performSegue(withIdentifier: "FreeExerciseDetail", sender: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FreeExerciseDetail"  {
            if let destinationVC = segue.destination as? freeExerciseDetail {
                
                destinationVC.mucle = selectedFreeExercisetargtedMoucle
                destinationVC.name = selectedFreeExerciseName
                destinationVC.image = selectedFreeExerciseImage
                //destinationVC.sets = selectedFreeExerciseSets
                
            }
        }
    }
    /////(observing the exercise from database)///////////////////////////////////////////////////////////
    func loadFreeExercise() {
        ref = Database.database().reference()
        ref.child("exerciesForALL").observe(.value, with: { (snapshot) in
            do {
                
                for snap in snapshot.children {
                    let excersSnap = snap as! DataSnapshot
                    let jsonData = try JSONSerialization.data(withJSONObject: excersSnap.value)
                    self.exerciseInfo = try? JSONDecoder().decode(ExerciseElement.self, from: jsonData)
                    if self.exerciseInfo?.targetedmuscle == self.nameOfmucle {
                        self.freeExercises.append(self.exerciseInfo!)
                    }
                }
                print(self.exerciseInfo)
                self.ExercisesTableView.reloadData()
                self.loading.stopAnimating()
                self.loading.isHidden = true
                self.ExercisesTableView.isHidden = false 
            } catch let error {
                print(error)
            }
        }){ (error) in
            print(error.localizedDescription)
        }
        
    }
    
}
