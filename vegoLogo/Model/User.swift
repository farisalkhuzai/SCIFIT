//
//  User.swift
//  vegoLogo
//
//  Created by Khaled Kutbi on ١٠ ذو. ق، ١٤٣٩ هـ.
//  Copyright © ١٤٣٩ هـ Khaled Kutbi. All rights reserved.
//

//   let user = try? JSONDecoder().decode(User.self, from: jsonData)
//
//import Foundation
//
//class User: NSObject,Codable {
//    var diet: [Diet]
//    var exercises: [Exercise]
//    var profile: Profile
//    
//    enum CodingKeys: String, CodingKey {
//        case diet = "Diet"
//        case exercises = "Exercises"
//        case profile = "Profile"
//    }
//    
//    init(diet: [Diet], exercises: [Exercise], profile: Profile) {
//        self.diet = diet
//        self.exercises = exercises
//        self.profile = profile
//    }
//}
//
//class Diet: NSObject,Codable {
//    var day: String
//    var dayMeals: [DayMeal]
//    var mealsCount, totalCals: String
//    
//    init(day: String, dayMeals: [DayMeal], mealsCount: String, totalCals: String) {
//        self.day = day
//        self.dayMeals = dayMeals
//        self.mealsCount = mealsCount
//        self.totalCals = totalCals
//    }
//}
//
//class DayMeal: NSObject,Codable {
//    var cal: String
//    var elements: [Element]
//    var image: String
//    var ingredients: [Ingredient]
//    var name: String
//    
//    init(cal: String, elements: [Element], image: String, ingredients: [Ingredient], name: String) {
//        self.cal = cal
//        self.elements = elements
//        self.image = image
//        self.ingredients = ingredients
//        self.name = name
//    }
//}
//
//class Element: NSObject,Codable {
//    var amount, name: String
//    
//    init(amount: String, name: String) {
//        self.amount = amount
//        self.name = name
//    }
//}
//
//class Ingredient: NSObject,Codable {
//    var quantity, type: String
//    
//    init(quantity: String, type: String) {
//        self.quantity = quantity
//        self.type = type
//    }
//}
//
//class Exercise: NSObject,Codable {
//    var day: String
//    var exercise: [ExerciseElement]
//    var exercisecount, targetedmuscles: String
//    
//    init(day: String, exercise: [ExerciseElement], exercisecount: String, targetedmuscles: String) {
//        self.day = day
//        self.exercise = exercise
//        self.exercisecount = exercisecount
//        self.targetedmuscles = targetedmuscles
//    }
//}
//
//class ExerciseElement: NSObject,Codable {
//    var exername: String
//    var image: String?
//    var sets: [Set]
//    var targetedmuscle: String
//    
//    init(exername: String, image: String?, sets: [Set], targetedmuscle: String) {
//        self.exername = exername
//        self.image = image
//        self.sets = sets
//        self.targetedmuscle = targetedmuscle
//    }
//}
//
//class Set: NSObject,Codable {
//    var reps, rm1, volume: String
//    var weight: String
//    
//    init(reps: String, rm1: String, volume: String, weight: String) {
//        self.reps = reps
//        self.rm1 = rm1
//        self.volume = volume
//        self.weight = weight
//    }
//}
//
////enum Weight: String, Codable {
////    case empty = ""
////    case weight = " "
////}
//
//class Profile: NSObject,Codable {
//    let adminBrief, age, height, isAdmin: String
//    let name, previousWeight, uid, userActivity: String
//    let userEmail, userGoal, weight: String
//    
//    init(adminBrief: String, age: String, height: String, isAdmin: String, name: String, previousWeight: String, uid: String, userActivity: String, userEmail: String, userGoal: String, weight: String) {
//        self.adminBrief = adminBrief
//        self.age = age
//        self.height = height
//        self.isAdmin = isAdmin
//        self.name = name
//        self.previousWeight = previousWeight
//        self.uid = uid
//        self.userActivity = userActivity
//        self.userEmail = userEmail
//        self.userGoal = userGoal
//        self.weight = weight
//    }
//}
// To parse the JSON, add this file to your project and do:
//
//   let user = try? newJSONDecoder().decode(User.self, from: jsonData)

// To parse the JSON, add this file to your project and do:
//
//   let user = try? newJSONDecoder().decode(User.self, from: jsonData)

import Foundation


class User: NSObject,Codable {
    var diet: [Diet]
    var exercises: [Exercise]
    var profile: Profile
    
    enum CodingKeys: String, CodingKey {
        case diet = "Diet"
        case exercises = "Exercises"
        case profile = "Profile"
    }
    
    init(diet: [Diet], exercises: [Exercise], profile: Profile) {
        self.diet = diet
        self.exercises = exercises
        self.profile = profile
    }
}

class Diet: NSObject,Codable {
    var week1, week2, week3, week4: [DietWeeks]
    
    init(week1: [DietWeeks], week2: [DietWeeks], week3: [DietWeeks], week4: [DietWeeks]) {
        self.week1 = week1
        self.week2 = week2
        self.week3 = week3
        self.week4 = week4
    }
}

class DietWeeks: NSObject,Codable {
    var day: String
    var dayMeals: [DayMeal]
    var mealsCount, totalCals: String
    
    init(day: String, dayMeals: [DayMeal], mealsCount: String, totalCals: String) {
        self.day = day
        self.dayMeals = dayMeals
        self.mealsCount = mealsCount
        self.totalCals = totalCals
    }
}

class DayMeal: NSObject,Codable {
    var cal: String
    var elements: [Element]
    var image: String
    var ingredients: [Ingredient]
    var name: String
    
    init(cal: String, elements: [Element], image: String, ingredients: [Ingredient], name: String) {
        self.cal = cal
        self.elements = elements
        self.image = image
        self.ingredients = ingredients
        self.name = name
    }
}

class Element: NSObject,Codable {
    var amount, name: String
    
    init(amount: String, name: String) {
        self.amount = amount
        self.name = name
    }
}

class Ingredient: NSObject,Codable {
    var quantity, type: String
    
    init(quantity: String, type: String) {
        self.quantity = quantity
        self.type = type
    }
}

class Exercise: NSObject,Codable {
    var week1, week2, week3, week4: [ExerciseWeeks]
    
    init(week1: [ExerciseWeeks], week2: [ExerciseWeeks], week3: [ExerciseWeeks], week4: [ExerciseWeeks]) {
        self.week1 = week1
        self.week2 = week2
        self.week3 = week3
        self.week4 = week4
    }
}

class ExerciseWeeks: NSObject,Codable {
    var day: String
    var exercise: [ExerciseElement]
    var exercisecount, targetedmuscles: String
    
    init(day: String, exercise: [ExerciseElement], exercisecount: String, targetedmuscles: String) {
        self.day = day
        self.exercise = exercise
        self.exercisecount = exercisecount
        self.targetedmuscles = targetedmuscles
    }
}

class ExerciseElement: NSObject,Codable {
    var exername, image: String
    var sets: [Set]
    var targetedmuscle: String
    
    init(exername: String, image: String, sets: [Set], targetedmuscle: String) {
        self.exername = exername
        self.image = image
        self.sets = sets
        self.targetedmuscle = targetedmuscle
    }
}

class Set: NSObject,Codable {
    var reps, rm1, volume, weight: String
    
    init(reps: String, rm1: String, volume: String, weight: String) {
        self.reps = reps
        self.rm1 = rm1
        self.volume = volume
        self.weight = weight
    }
}

class Profile: NSObject,Codable {
    var adminBrief, age, height, isAdmin: String
    var name, previousWeight, uid, userActivity: String
    var userEmail, userGoal, weight: String
    
    init(adminBrief: String, age: String, height: String, isAdmin: String, name: String, previousWeight: String, uid: String, userActivity: String, userEmail: String, userGoal: String, weight: String) {
        self.adminBrief = adminBrief
        self.age = age
        self.height = height
        self.isAdmin = isAdmin
        self.name = name
        self.previousWeight = previousWeight
        self.uid = uid
        self.userActivity = userActivity
        self.userEmail = userEmail
        self.userGoal = userGoal
        self.weight = weight
    }
}
