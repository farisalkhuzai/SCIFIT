//
//  test.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٨ محرم، ١٤٤٠ هـ.
//  Copyright © ١٤٤٠ هـ Khaled Kutbi. All rights reserved.
//

import Foundation

class freeExercise : NSObject,Codable {
    var freeExerName: String
    var image: String?
    var sets: [Set]
    var targetedMuscle: String
    
    init(exername: String, image: String?, sets: [Set], targetedmuscle: String) {
    self.freeExerName = exername
    self.image = image
    self.sets = sets
    self.targetedMuscle = targetedmuscle
    }
}
