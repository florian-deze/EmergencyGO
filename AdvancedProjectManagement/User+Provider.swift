//
//  User+Provider.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 20/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import Foundation

extension User {
    
    override class func entityName() -> String {
        return "User"
    }
    
    static func UserOrNew(withIdentifier identifier:String) -> User? {
        if let user = self.objectWith(predicate: NSPredicate(format: "identifier = %@", identifier)) as? User {
            return user
        }
        if let user = self.newObjectInstance() as? User {
            user.identifier = identifier
            
            CoreDataManager.shared.saveContext()
            return user
        }
        return nil
    }
    
    static func allUser() -> [User]? {
        return (self.allObjects() as? [User])
    }
    
}
