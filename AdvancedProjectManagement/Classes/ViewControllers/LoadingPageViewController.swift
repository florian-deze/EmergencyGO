//
//  LoadingPageViewController.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 24/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import UIKit

class LoadingPageViewController: UIViewController {

    @IBOutlet weak var imageLogo: UIImageView!
    private var count:Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 0
        _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func isAnyData() -> Bool {
        if let users = User.allObjects() {
            if users.count>0 {
                return true
            }
        }
        return false
    }
    
    public func nextPage() {
        if count>=1{
            if isAnyData() {
                performSegue(withIdentifier: LOADING_TO_SEND_ALERT, sender: "")
            }
            else {
                performSegue(withIdentifier: LOADING_TO_REGISTER_FIRST, sender: "")
            }
        }
        count = count + 1
    }

}
