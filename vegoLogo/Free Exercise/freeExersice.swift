//
//  freeExersice.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٧ محرم، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import UIKit
import Firebase

class freeExersice: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
    
    @IBOutlet weak var collictionView: UICollectionView!
   
    var ImagesOfMucles : [String] = ["ظهر.png","بطن.png","صدر.png","اكتاف.png","تراي.png","باي.png","افخاذ.png","بطات.png"]
    var namesOfMucles = ["ظهر","بطن","صدر","اكتاف","تراي","باي","افخاذ","بطات",]
    
    var ref:DatabaseReference!
    var selectedExerciseName: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designItemOfCollictionView()
        collictionView.dataSource = self
        collictionView.delegate = self
        ref = Database.database().reference()
    
      
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

  ////////////(Contoller for the colliction view in this class)/////////////////////////////////////////
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ImagesOfMucles.count
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! freeExersiceCell
        cell.freeExeciseImage.image = UIImage(named: ImagesOfMucles[indexPath.row])
        cell.nameOfMucleLabel.text = namesOfMucles[indexPath.row]
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        self.selectedExerciseName = namesOfMucles[indexPath.row]

        
    self.performSegue(withIdentifier: "toGroupOfExercises", sender: nil)
    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGroupOfExercises"  {
            if let destinationVC = segue.destination as? freeExercisesTable {
                destinationVC.nameOfmucle = self.selectedExerciseName
              //  destinationVC.nameOfmucle =
                
            }
        }
    }

    
    
 
     ////////////////(just designin)//////////////////////////////////////////
    
    func designItemOfCollictionView() {
        let itemSize = UIScreen.main.bounds.width/3-3
        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsetsMake(10, 5, 5, 5)
        layout.itemSize = CGSize(width: 100, height: 160)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        collictionView.collectionViewLayout = layout
        
    }
    
    
    

  

}
