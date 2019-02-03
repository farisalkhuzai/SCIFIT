//
//  Logger.swift
//  Bella Delegator
//
//  Created by Muhammad Fatani on 6/19/17.
//  Copyright © 2017 Alakatk. All rights reserved.
//

import Foundation

/// struct need to print the data in the cosole, this is for the programmer just
struct Logger {
    
    
    /// Call for normal mode
    ///
    /// - Parameters:
    ///   - tag: like a key
    ///   - message: show the meessage that you want
    static func normal(tag:String, message:Any){
        
        print("😃 \(tag) : \(message)")
       // Crashlytics.sharedInstance().setObjectValue(message, forKey: "😃 \(tag)")
        
    }
    
    /// Call for error mode
    ///
    /// - Parameters:
    ///   - tag: like a key
    ///   - message: show the meessage that you want
    static func error(tag:String, message:Any){
        print("😡 \(tag) : \(message)")
       // Crashlytics.sharedInstance().setObjectValue(message, forKey: "😡 \(tag)")
        
    }
    
}
