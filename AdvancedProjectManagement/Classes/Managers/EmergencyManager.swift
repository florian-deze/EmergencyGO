//
//  EmergencyManager.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 13/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import Foundation
import UIKit

class EmergencyManager : NSObject {
    
    static var instance:EmergencyManager?
    static var state:String?
    
    public static func shared() -> EmergencyManager {
        if instance == nil {
            instance = EmergencyManager()
        }
        return instance!
    }
    
    public static func getUserIdFromCoreData() -> String? {
        if let users = User.allUser() {
            return users[0].identifier
        }
        return ""
    }
    
    /*
     * Get the emergency state
     */
    
//    public static func getEmergencyState() -> String?{
//        if let ident = self.getEmergencyState() {
//            let newState:String? = WebServiceManager.parserEmergencyState(withIdentifier: ident)
//            if self.state == nil {
//                self.state = newState
//            }
//            else {
//                if self.state != newState {
//                    self.state = newState
//                }
//            }
//            return self.state
//        }
//        return ""
//    }
}
