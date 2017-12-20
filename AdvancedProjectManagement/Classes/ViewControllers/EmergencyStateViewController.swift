//
//  EmergencyStateViewController.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 09/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class EmergencyStateViewController: UIViewController {

    //MARK:- OUTLET
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var emergencyEmployeeName: UILabel!
    @IBOutlet weak var emergencyEmployeeEmail: UILabel!
    
    //MARK:- VARIABLES
    var employeeId:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.postData()
        // Do any additional setup after loading the view.
        //call changing state function with a timer : when it is done, the variable and the page will disapear
        _ = Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(getInfoFromFireBaseAlarm), userInfo: nil, repeats: true)
        _ = Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(getInfoFromFireBaseEmployee), userInfo: nil, repeats: true)
        //getting data
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func getInfoFromFireBaseAlarm() {
        let ref = Database.database().reference(withPath: "Alarm/7000")
        var alarmData:[String:AnyObject]?
        ref.observe(.value, with: { snapshot in
            alarmData = snapshot.value as? [String:AnyObject]
            if let data = alarmData {
                self.CheckAndChangeState(withData: data)
            }
        })
    }
    
    public func getInfoFromFireBaseEmployee() {
        let ref = Database.database().reference(withPath: "Employee/2000")
        var employeeData:[String:AnyObject]?
        ref.observe(.value, with: { snapshot in
            employeeData = snapshot.value as? [String:AnyObject]
            if let data = employeeData {
                self.CheckAndChangeEmployee(withData: data)
            }
        })
    }
    
    public func CheckAndChangeState(withData data : [String:AnyObject]) {
        
        if let dataId = data["employeeId"] as? String {
            self.employeeId = dataId
        }
        let state = data["treat_enum"]
        
        //Add info to storyboard
        self.state.text = state as! String
        
    }
    
    public func CheckAndChangeEmployee(withData data : [String:AnyObject]) {
        self.emergencyEmployeeName.text = data["Name"] as? String
        self.emergencyEmployeeEmail.text = data["Email"] as? String
    }
    
//    public func CheckAndChangeState() {
//        print("******call checkAndChange*******\n")
//        //get info from online
//        MGetAndPostData.downloadItems()
//        if let users = User.allUser() {
//            if let ident = users[0].identifier {
//                let emergencyInfo = MGetAndPostData.shared.informationDownlAndParse
//                let state = emergencyInfo[STATE] as? String
//                self.emergencyEmployeeName.text = emergencyInfo[EM_NAME] as? String
//                self.emergencyEmployeeEmail.text = emergencyInfo[EM_EMAIL] as? String
//                var newState = ""
//                
//                //compare with old result
//                if state != self.state.text, state != "" {
//                    //change if necessary
//                    newState = self.state.text!
//                }
//                
//                //decision based on state
//                if newState != "none" {
//                    self.state.text = newState
//                }
//                else if newState != "" {
//                    self.performSegue(withIdentifier: EMERGENCY_TO_SEND_ALERT, sender: "")
//                }
//            }
//        }
//        
//    }
//    
//    public func postData() {
//        var data:[String:Any] = [:]
//        data.updateValue("23243", forKey: "id")
//        data.updateValue("william", forKey: "name")
//        data.updateValue("state", forKey: "ambulace come")
//        do {
//            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
//            //send data
//            MGetAndPostData.postData(withData: jsonData)
//        }catch let error as Error {
//            print(error)
//        }
//    }

}
