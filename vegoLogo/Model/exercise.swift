//
//  exercise.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ٢٣ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

//   let exercies = try? JSONDecoder().decode(Exercies.self, from: jsonData)

import Foundation

typealias Exercies = [String: ExerciesValue]

class ExerciesValue: Codable {
    var exername, image, targetedmuscle: String
    
    init(exername: String, image: String, targetedmuscle: String) {
        self.exername = exername
        self.image = image
        self.targetedmuscle = targetedmuscle
    }
}
