//
//  Random.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 09/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import Foundation
import Darwin

public class MyRandom : NSObject {
    
    static func GenerateRandomId(withSize nSize : Int) -> Double{
        var res:Double = Double(arc4random_uniform(10))
        for _ in 0..<nSize-1 {
            res = res * 10
            res = res + Double(arc4random_uniform(10))
        }
        return res
    }
}
