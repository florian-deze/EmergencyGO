//
//  FriendOrFamily+CoreDataProperties.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 23/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import Foundation
import CoreData


extension FriendOrFamily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendOrFamily> {
        return NSFetchRequest<FriendOrFamily>(entityName: "FriendOrFamily")
    }

    @NSManaged public var identifier: String?
    @NSManaged public var firstnameF: String?
    @NSManaged public var lastNameF: String?
    @NSManaged public var emailF: String?
    @NSManaged public var addressF: String?
    @NSManaged public var phoneNumberF: String?

}
