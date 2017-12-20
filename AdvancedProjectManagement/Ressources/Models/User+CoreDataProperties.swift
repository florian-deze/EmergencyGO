//
//  User+CoreDataProperties.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 20/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var email: String?
    @NSManaged public var falseAlarm: Int16
    @NSManaged public var firstName: String?
    @NSManaged public var identifier: String?
    @NSManaged public var lastName: String?
    @NSManaged public var nationality: String?
    @NSManaged public var phoneNumber: String?

}
