//
//  NSManagedObject+Provider.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 20/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import UIKit
import CoreData

// PROVIDER
extension NSManagedObject {
    
    class func entityName() -> String {
        NSException.raise(NSExceptionName(rawValue: "Implementation exception"), format: "Needs override", arguments: getVaList(["nil"]))
        return ""
    }
    
    // MARK: - used to create
    static func newObjectInstance() -> NSManagedObject? {
        return self.newObjectInstanceFor(entity: self.entityName())
    }
    
    private static func newObjectInstanceFor(entity sEntity:String) -> NSManagedObject? {
        let objectContext:NSManagedObjectContext = CoreDataManager.shared.managedObjectContext
        let managedObject:NSManagedObject = NSEntityDescription.insertNewObject(forEntityName: sEntity, into: objectContext)
        return managedObject
    }
    
    // MARK: - used to retrieve all objects
    static func allObjects() -> [AnyObject]? {
        return allObjectsFor(entity: self.entityName())
    }
    
    private static func allObjectsFor(entity sEntity:String) -> [AnyObject]? {
        var results:[AnyObject]? = nil
        
        let fetchRequest:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>();
        let objectContext:NSManagedObjectContext = CoreDataManager.shared.managedObjectContext
        if let entityDesc:NSEntityDescription = NSEntityDescription.entity(forEntityName: sEntity, in: objectContext) {
            fetchRequest.entity = entityDesc
            do {
                results = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            }
            catch let error {
                print("\(self.entityName()) error : \(error)")
            }
        }
        return results
    }
    
    // MARK: - used to retrieve an object with a predicate
    static func objectWith(predicate sPredicate:NSPredicate) -> AnyObject? {
        return self.objectWith(entity: self.entityName(), andPredicate: sPredicate)
    }
    
    private static func objectWith(entity sEntity:String, andPredicate sPredicate:NSPredicate) -> AnyObject? {
        var results:[AnyObject]? = nil
        
        let fetchRequest:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>();
        let objectContext:NSManagedObjectContext = CoreDataManager.shared.managedObjectContext
        if let entityDesc:NSEntityDescription = NSEntityDescription.entity(forEntityName: sEntity, in: objectContext) {
            fetchRequest.entity = entityDesc
            fetchRequest.predicate = sPredicate
            fetchRequest.fetchLimit = 1
            do {
                results = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            }
            catch let error {
                print("\(self.entityName()) error : \(error)")
            }
        }
        return results?.first
    }
    
    static func objectsWith(predicate sPredicate:NSPredicate) -> [AnyObject]? {
        return self.objectsWith(entity: self.entityName(), andPredicate: sPredicate)
    }
    
    // MARK: - used to retrieve a list of objects with a predicate
    private static func objectsWith(entity sEntity:String, andPredicate sPredicate:NSPredicate) -> [AnyObject]? {
        
        let fetchRequest:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>();
        let objectContext:NSManagedObjectContext = CoreDataManager.shared.managedObjectContext
        if let entityDesc:NSEntityDescription = NSEntityDescription.entity(forEntityName: sEntity, in: objectContext) {
            fetchRequest.entity = entityDesc
            fetchRequest.predicate = sPredicate
            do {
                return try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
            }
            catch let error {
                print("\(self.entityName()) error : \(error)")
            }
        }
        
        return nil
    }
    
    // MARK: - used to remove objects
    static func removeAllObjects() -> Bool {
        return self.removeAllObjectsWith(entity: self.entityName())
    }
    
    private static func removeAllObjectsWith(entity sEntity:String) -> Bool {
        let fetchRequest:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>();
        let objectContext : NSManagedObjectContext = CoreDataManager.shared.managedObjectContext
        if let entityDesc:NSEntityDescription = NSEntityDescription.entity(forEntityName: sEntity, in: objectContext) {
            fetchRequest.entity = entityDesc
            fetchRequest.includesPropertyValues = false
            do {
                let results:[AnyObject] = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
                for result in results {
                    self.remove(object: result as! NSManagedObject)
                }
                return true
                
            }
            catch let error {
                print("\(self.entityName()) error : \(error)")
            }
        }
        return false
    }
    
    static func removeObjectsWith(predicate sPredicate:NSPredicate) -> Bool {
        return self.removeObjectsWith(entity: self.entityName(), andPredicate: sPredicate)
    }
    
    private static func removeObjectsWith(entity sEntity:String, andPredicate sPredicate:NSPredicate) -> Bool {
        let fetchRequest:NSFetchRequest = NSFetchRequest<NSFetchRequestResult>();
        let objectContext:NSManagedObjectContext = CoreDataManager.shared.managedObjectContext
        if let entityDesc:NSEntityDescription = NSEntityDescription.entity(forEntityName: sEntity, in: objectContext) {
            fetchRequest.entity = entityDesc
            fetchRequest.predicate = sPredicate
            fetchRequest.includesPropertyValues = false
            do {
                let results:[AnyObject] = try CoreDataManager.shared.managedObjectContext.fetch(fetchRequest)
                for result in results {
                    self.remove(object: result as! NSManagedObject)
                }
                return true
            }
            catch let error {
                print("\(self.entityName()) error : \(error)")
            }
            
        }
        return false
    }
    
    // MARK: - used to remove an object
    static func remove(object sObject:NSManagedObject) {
        CoreDataManager.shared.managedObjectContext.delete(sObject)
    }
}
