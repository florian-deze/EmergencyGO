//
//  ReachabilityManager.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 27/09/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import UIKit
import Reachability

protocol ReachabilityManagerDelegate: class {
    func handleNetworkCHange()
}

class MFReachabilityManager: NSObject {
    
    // MARK: - Properties
    var mCurrentInternetConnection:Reachability?
    var mCurrentReachability:Bool?
    
    //MARK: - delegate
    private var delegates = [ReachabilityManagerDelegate]()
    
    //MARK: instance
    static var mInstance : MFReachabilityManager?
    
    static func shared() -> MFReachabilityManager {
        if (mInstance == nil) {
            mInstance = MFReachabilityManager()
        }
        return mInstance!
    }
    
    //method to init current connection and subscribe notif
    override init() {
        super.init()
        mCurrentInternetConnection = Reachability.forInternetConnection()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNetworkChange), name: NSNotification.Name.reachabilityChanged, object: nil)
        handleNetworkChange()
        mCurrentInternetConnection?.startNotifier()
    }
    
    //notification
    func handleNetworkChange(){
        switch Reachability.forInternetConnection().currentReachabilityStatus() {
        case .NotReachable:
            mCurrentReachability = false
        case .ReachableViaWiFi:
            mCurrentReachability = true
        case .ReachableViaWWAN:
            mCurrentReachability = true
        }
        for delegate in delegates{
            delegate.handleNetworkCHange()
        }
    }
    
    //add and remove delegate
    func addDelegate(delegate:ReachabilityManagerDelegate) {
        if !(delegates.contains(where: { $0 === delegate })) {
            delegates.append(delegate)
        }
    }
    
    func removeDelegate(delegate:ReachabilityManagerDelegate) {
        if let index = delegates.index(where: { $0 === delegate }) {
            delegates.remove(at: index)
        }
    }
    
}
