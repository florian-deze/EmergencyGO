//
//  UrlHelper.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 27/09/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import UIKit

class UrlHelper: NSObject {
    
    public static func getWebServiceUrl() -> String {
        return WEB_SERVICE_URL
    }
    
    public static func getWebServiceUrlState() -> String {
        return (self.getWebServiceUrl() + WEB_SERVICE_URL_STATE)
    }
    
    public static func getWebServiceUrlEmergency() -> String {
        return (self.getWebServiceUrl() + WEB_SERVICE_URL_EMERGENCY)
    }
    
    public static func getWebServiceUrlRegistration() -> String {
        return (self.getWebServiceUrl() + WEB_SERVICE_URL_REGISTRATION)
    }
    
}
