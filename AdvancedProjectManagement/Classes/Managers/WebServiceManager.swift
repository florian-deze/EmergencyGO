//
//  WebServiceManager.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 12/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import Foundation
import UIKit

class WebServiceManager : NSObject {
    //add functionality for only state reteiving
    public func parserEmergencyState(withIdentifier iden:String) -> [String:Any] {
        var res:[String:Any] = [:]
        let webServiceManagervar:WebServiceManager = WebServiceManager()
        webServiceManagervar.getNewElement(with: iden, onSuccess: { (data) in
            //parse data
            let results = PrepareAndSendData.parserData(withData: data)
            if results.count>0 {
            let user = results[0]
            if let userState = (user["state"]) as? String,
                let userEmployeeName = (user["EmployeeName"]) as? String {
                    res = ["state":userState,"EmployeeName":userEmployeeName]
            }
            }
        }) { (num, error) in
            print(error)
        }
        
//        let data = webServiceManagervar.getNewElement()
//        print("data : \(data)")
//        if data != nil {
//            webServiceManagervar.parseData(withdata: data!)
//        }
        return res
    }
    
    //post registration information or emergency call
    
    public static func sendDataToServer(withParameters urlParameters:String? = nil,withjson jsonData: [String:Any], onSuccess success: @escaping MF_DATA_REQUEST_COMPLETION_CLOSURE, and failure:@escaping MF_DATA_REQUEST_FAILED_CLOSURE){
        
        var url = UrlHelper.getWebServiceUrl()
        
        if let parameters = urlParameters {
            url = url + parameters
        }
        
        MFAFNetworkingManager.shared().beginRequestWith(parameters: [:], url: url, httpMethod: .post, parseResultHandler: nil, completionHandler: success, failedHandler: failure)
        
    }
    
    //get information from appServer
    public func getNewElement(with parameters:String? = nil, onSuccess success: @escaping MF_DATA_REQUEST_COMPLETION_CLOSURE, and failure:@escaping MF_DATA_REQUEST_FAILED_CLOSURE){
        
        var url = UrlHelper.getWebServiceUrl()
        
//        if let parameters = parameters {
//            url = url + parameters
//        }
//        
        MFAFNetworkingManager.shared().beginRequestWith(parameters: [:], url: url, httpMethod: .get, parseResultHandler: nil, completionHandler: success, failedHandler: failure)
    }
    
//    public func getNewElement() -> Data? {
//        
//        let url: URL = URL(string: UrlHelper.getWebServiceUrl())!
//        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
//        var res:Data?
//        let task = defaultSession.dataTask(with: url) { (data, response, error) in
//            
//            if error != nil {
//                print("Failed to download data")
//            }else {
//                print("Data downloaded")
//                print(data)
//                print(response)
//                res = data!
//            }
//            
//        }
//        task.resume()
//        return res
//    
//    
//    }
//    
//    
//    public func parseData(withdata data: Data) {
////        var jsonResult = NSArray()
////        
////        do{
////            jsonResult = try JSONSerialization.jsonObject(with: data, options:JSONSerialization.ReadingOptions.allowFragments) as! NSArray
////            
////        } catch let error as NSError {
////            print(error)
////            
////        }
////        
////        var jsonElement = NSDictionary()
////        
////        for i in 0 ..< jsonResult.count
////        {
////            
////            jsonElement = jsonResult[i] as! NSDictionary
////            if let name = jsonElement["Name"] as? String,
////                let address = jsonElement["Address"] as? String,
////                let latitude = jsonElement["Latitude"] as? String,
////                let longitude = jsonElement["Longitude"] as? String
////            {
////                print(name)
////            }
////        }
////    }
//    do {
//        if let json = try JSONSerialization.jsonObject(with: data) as? [String: String], let name = json["name"] {
//            print("name = \(name)")   // if everything is good, you'll see "William"
//        }
//    } catch let parseError {
//        print("parsing error: \(parseError)")
//        let responseString = String(data: data, encoding: .utf8)
//        print("raw response: \(responseString)")
//    }
//    }
}
