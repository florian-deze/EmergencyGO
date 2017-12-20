//
//  MFAFNetworkingManager.swift
//  baseapp
//
//  Created by Aurélien Debarge on 10/04/2017.
//  Copyright © 2017 Julien Koziel. All rights reserved.
//

import Foundation
import Alamofire

typealias MF_PARSE_RESULT_CLOSURE = (_ data:Any) -> (Data);
typealias MF_DATA_REQUEST_COMPLETION_CLOSURE = (_ data:Data) -> ();
typealias MF_DATA_REQUEST_FAILED_CLOSURE = (_ statusCode:Int, _ error:NSError?) -> ();

let BASE_URL = ""

class MFAFNetworkingManager {
    
    //MARK: - Instance
    static var instance:MFAFNetworkingManager?
    
    static func shared() -> MFAFNetworkingManager {
        if instance == nil {
            instance = MFAFNetworkingManager()
        }
        return instance!
    }
    
    // check reachability
    private func _canUseNetwork() -> Bool{
        return MFReachabilityManager.shared().mCurrentReachability == true
    }
    
    func beginRequestWith(parameters:[String: Any],
                          url stringUrl:String,
                          shouldUseBaseURL:Bool? = true,
                          httpMethod:HTTPMethod,
                          parseResultHandler:MF_PARSE_RESULT_CLOSURE?,
                          completionHandler:@escaping MF_DATA_REQUEST_COMPLETION_CLOSURE,
                          failedHandler:@escaping MF_DATA_REQUEST_FAILED_CLOSURE) {
        if _canUseNetwork() {
            print(stringUrl)
            let url:String = shouldUseBaseURL == true ? "\(BASE_URL)\(stringUrl)" : stringUrl
            
            let header = ["Content-Type" : "application/json"]
            
            Alamofire.request(url, method: httpMethod, parameters: parameters, encoding: JSONEncoding.default, headers: header).responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    if let data = response.data {
                        if let _parseResultHandler = parseResultHandler {
                            completionHandler(_parseResultHandler(data))
                        }
                        completionHandler(data)
                    }
                    else {
                        failedHandler(-1, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("unknown_error", comment: "unknown_error")]))
                    }
                case .failure(let error):
                    
                    if let headers = response.response?.allHeaderFields {
                        print(headers)
                    }
                    
                    failedHandler(-1, error as NSError?)
                }
            })
        }
        else {
            failedHandler(0, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : NSLocalizedString("no_connection", comment: "no_connection")]))
        }
    }
}
