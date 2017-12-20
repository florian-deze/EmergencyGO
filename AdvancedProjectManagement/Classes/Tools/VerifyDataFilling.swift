//
//  VerifyDataFilling.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 09/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import Foundation
import UIKit

public class VerifyDataFilling : NSObject {
    
    static func isFilled(withTextField inputText : UITextField) -> Bool{
        if inputText.text != ""  {
            return true
        }
        else {
            return false
        }
    }
    
    static func isFilledWithNumbers(withTextField inputText : UITextField) -> Bool {
        var res:Bool = false
        if let text = inputText.text {
            if text != "" {
                for char in text.characters {
                    if (Int(String(char))!>=0) && (Int(String(char))!.hashValue<=9) {
                        res = true
                    }
                }
            }
        }
        return res
    }
    
    static func isFilledWithLetters(withTextField inputText : UITextField) -> Bool {
        var res:Bool = false
        if let text = inputText.text {
            if text != "" {
                for char in text.characters {
                    if ((char.hashValue>=65) && (char.hashValue<=90)) || ((char.hashValue>=97) && (char.hashValue<=122)) {
                        res = true
                    }
                }
            }
        }
        return res
    }
    
    static func isAnEmailAddress(withTextField inputText : UITextField) -> Bool {
        var res:Bool = false
        var c:Int = 0
        if let text = inputText.text {
            for char in text.characters {
                if (char == "@") && (c >= 0){
                    c+=1
                }
                if (char == ".") && (c >= 1){
                    c+=1
                }
            }
        }
        if c == 2 {
            res = true
        }
        return res
    }
}
