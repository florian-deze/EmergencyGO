//
//  MGetPostData.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 29/11/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import Foundation

class MGetAndPostData : NSObject {
    
    public var informationDownlAndParse:[String:String] = [:]
    
    static let shared: MGetAndPostData = {
        return MGetAndPostData()
    }()
    
    public static func postData(withData jsonData : Data) {
        
        JSONSerialization.isValidJSONObject(jsonData)
        
        let myURL = URL(string: WEB_SERVICE_URL_TO_SEND)!
        let request = NSMutableURLRequest(url: myURL)
        request.httpMethod = "POST"
        
        
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            print(response)
        }
        task.resume()
    }
    
    
    public static func downloadItems() {
        
        let url = URL(string: WEB_SERVICE_URL_TO_GET)!
        let request = URLRequest(url: url)
        // modify the request as necessary, if necessary
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("request failed \(error)")
                return
            }
            print(data)
            do {
                if let json = try JSONSerialization.jsonObject(with: data) as? [String: String] {
                    MGetAndPostData.shared.informationDownlAndParse = json
                }
            } catch let parseError {
                print("parsing error: \(parseError)")
                let responseString = String(data: data, encoding: .utf8)
                print("raw response: \(responseString)")
            }
        }
        task.resume()
    }
}
