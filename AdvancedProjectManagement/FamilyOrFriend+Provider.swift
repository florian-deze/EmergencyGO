//
//  FamilyOrFriend+Provider.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 23/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import Foundation

extension FriendOrFamily {
    
    override class func entityName() -> String {
        return "FriendOrFamily"
    }
    
    static func FriendFamilyOrNew(withIdentifier identifier:String) -> FriendOrFamily? {
        if let user = self.objectWith(predicate: NSPredicate(format: "identifier = %@", identifier)) as? FriendOrFamily {
            return user
        }
        if let user = self.newObjectInstance() as? FriendOrFamily {
            user.identifier = identifier
            
            CoreDataManager.shared.saveContext()
            return user
        }
        return nil
    }
    
}
