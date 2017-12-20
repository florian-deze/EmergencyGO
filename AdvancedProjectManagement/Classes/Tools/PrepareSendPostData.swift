//
//  PrepareAndSendData.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 12/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import Foundation
import UIKit

class PrepareAndSendData : NSObject {
    
    public static func transformNSDataToJSONFormat(withNSData nsData: NSData) -> NSData {
        return NSData()
    }

    public static func parserData(withData data: Data?) -> Array<AnyObject> {
        do {
            if let data = data, let response = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions(rawValue:0)) as? Array<AnyObject> {
                return(response)
            }
            else {
                print("JSON Error, information is empty")
                return Array<AnyObject>()
            }
        }
        catch let error as NSError {
            print("Error parsing results: \(error.localizedDescription)")
            return Array<AnyObject>()
        }
    }
    
}
