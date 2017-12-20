//
//  SendAlertViewController.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 29/09/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import UIKit
import CoreLocation
import Firebase

class SendAlertViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {
        
    
    @IBOutlet weak var sendAlertTableView: UITableView!
    
    let locationManager = CLLocationManager()
    var numberOfCells:Int = 0
    var elementInCells:[String]? = []
    var indice:Int! = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "EmergencyTypesAndPriorities", ofType: "plist") {
            let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject]
            addElementInView(withDict : dict as NSDictionary?)
        }
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        self.sendToFireBase()

    }
    
    private func addElementInView(withDict dict : NSDictionary?) {
        if let d = dict {
            for i in 0...d.count-1 {
                //elementInCells = d.allValues as? [String]
                let indice = i+1
                let key = "Priority \(indice)"
                if let value = d.value(forKey: key) as? [String] {
                    for element in value {
                        elementInCells?.append(element)
                    }
                }
                //elementInCells = elementInCells + dict["Priority 3"]
            }
            if let element = elementInCells {
                numberOfCells = element.count
            }

        }
    }
    
    private func getCoordinateOfUserLatitude() -> Double {
        if let location = locationManager.location {
            let latitude = location.coordinate.latitude
            return Double(latitude)
        }
        return 0
    }
    
    private func getCoordinateOfUserLongitude() -> Double {
        if let location = locationManager.location {
            let longitude = location.coordinate.longitude
            return Double(longitude)
        }
        return 0
    }
    
    //MARK:- DELEGATE METHODE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.sendAlertTableView.dequeueReusableCell(withIdentifier: "CellSendAlert", for: indexPath) as? sendAlertTableViewCell , let element = self.elementInCells {
            if indice < numberOfCells {
                cell.nameOfEmergency.setTitle(element[self.indice], for: .normal)
                indice = indice+1
                return cell
            }
        }
        
        return UITableViewCell()
    }

    
//    private func dataToSendInJSON() -> [String:Any] {
//        var dict:[String:Any] = [:]
//        if let id = EmergencyManager.getUserIdFromCoreData() {
//            dict.updateValue(id, forKey: "id")
//            dict.updateValue(self.getCoordinateOfUserLatitude(), forKey: "latitude")
//            dict.updateValue(self.getCoordinateOfUserLongitude(), forKey: "longitude")
//            dict.updateValue("brokenleg", forKey: "emergencyType")
//            dict.updateValue(3, forKey: "priority")
//        }
//        return dict
//        
//    }
    
//    private func sendDataToWebServer(){
//        WebServiceManager.sendDataToServer(withParameters: "", withjson: self.dataToSendInJSON(), onSuccess: { (data) in
//            self.performSegue(withIdentifier: SEND_ALERT_TO_EMERGENCY, sender: "")
//        }) { (num, error) in
//            print("*********** error sendEmergency ***********")
//            print(error)
//            print(num)
//            print("end error sendEmergency")
//        }
//    }
    
    private func sendToFireBase(){
    //sending data
    let path =  "Alarm"
    let ref = Database.database().reference(withPath: path)
        let data = ["id":"7000","user":"326","employee":"-1","priority":"3","treat_enum":"undefined","longitude":"43.234435","latitude":"42.23435","time":"2017-11-16 6:56:45"]
    let toSend = ref.child("7000")
    print(self.userId)
    toSend.ref.updateChildValues(data)
    }
    
    private func userId() -> String {
//        let users = User.allUser()
//        if let user = users?[0] {
//            return "324"
//        }
//        else {
//            return ""
//        }
        return "324"
    }

}
