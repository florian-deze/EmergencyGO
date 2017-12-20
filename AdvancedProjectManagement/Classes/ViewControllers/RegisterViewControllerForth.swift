//
//  RegisterViewControllerThird.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 09/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewControllerForth: UIViewController {
    
    //MARK:- OUTLET
    @IBOutlet weak var firstNameF: UITextField!
    @IBOutlet weak var lastNameF: UITextField!
    @IBOutlet weak var emailF: UITextField!
    @IBOutlet weak var phoneNumberF: UITextField!
    @IBOutlet weak var addressNApptF: UITextField!
    @IBOutlet weak var addressNStreetF: UITextField!
    @IBOutlet weak var addressStreetF: UITextField!
    @IBOutlet weak var addressPostCodeF: UITextField!
    @IBOutlet weak var addressCityF: UITextField!

    //MARK:- BUTTON
    @IBOutlet weak var registerButton: UIButton!
    
    //MARK:- VARIABLES
    public var userId:Double?
    public var diseases:[String:String]?
    public var allergies:[String:String]?
    public var allUserData:[String:Any]?
    public var friendOrFamilyId:Double?
    public var friendOrFamilyArray:[String:Any] = [:]

    
    override func viewDidLoad() {
        super.viewDidLoad()

       friendOrFamilyId = MyRandom.GenerateRandomId(withSize: SIZE_KEY_ID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- PRIVATE FUNCTION
    private func isAllDataFilled() -> Bool {
        var res:Bool = true
        let subviews = self.view.subviews
        let exceptionsEmpty:[UITextField] = [self.addressNApptF]
        for subview in subviews {
            if let text = subview as? UITextField {
                if text != exceptionsEmpty[0] {
                    if !(VerifyDataFilling.isFilled(withTextField: text)) {
                        text.layer.borderColor = UIColor.red.cgColor
                        text.layer.borderWidth = 1.0
                        res = false
                    }
                }
            }
        }
        return res
    }
    
    private func isCorrectEmailFormat() -> Bool {
        let res = VerifyDataFilling.isAnEmailAddress(withTextField: emailF)
        if res {
            return true
        }
        else {
            emailF.layer.borderColor = UIColor.red.cgColor
            emailF.layer.borderWidth = 1.0
            return false
        }
    }
    
    private func isFilledWithOnlyNumbers() -> Bool {
        let res = VerifyDataFilling.isFilledWithNumbers(withTextField: self.addressNApptF)
        if res {
            return true
        }
        else {
            addressNApptF.layer.borderColor = UIColor.red.cgColor
            addressNApptF.layer.borderWidth = 1.0
            return false
        }
        
    }
    
    private func isFormFilledCorrectlly() -> Bool {
        return (self.isAllDataFilled() && (isCorrectEmailFormat()) && (isFilledWithOnlyNumbers()))
    }
    
    private func createFullAddress() -> String {
        var fullAddress:String = ""
        if let nText = self.addressNApptF.text, nText != "" {
            fullAddress = nText
            fullAddress = "Appt n°"+fullAddress + " "
        }
        if let addNS = self.addressNStreetF.text,
            let addS = self.addressStreetF.text,
            let addC = self.addressCityF.text,
            let addP = self.addressPostCodeF.text {
            fullAddress = fullAddress + "Street N°" + addNS + " "
            fullAddress = fullAddress + addS + " "
            fullAddress = fullAddress + addC + " "
            fullAddress = fullAddress + addP
        }
        return fullAddress
    }

    private func saveInCoreData() {
        if let idS = friendOrFamilyId {
            if let friendOrFamily = FriendOrFamily.FriendFamilyOrNew(withIdentifier: "\(idS)") {
                friendOrFamily.firstnameF = self.firstNameF.text
                friendOrFamily.lastNameF = self.lastNameF.text
                friendOrFamily.emailF = self.emailF.text
                friendOrFamily.phoneNumberF = self.phoneNumberF.text
                friendOrFamily.addressF = self.createFullAddress()
                CoreDataManager.shared.saveContext()
            }
        }
        if let id = userId {
            if let newUser = User.UserOrNew(withIdentifier: "\(id)"), let userData = self.allUserData {
                newUser.firstName = userData[USER_NAME] as? String
                newUser.lastName  = userData[USER_LASTNAME] as? String
                newUser.age = (userData[USER_AGE] as? Int16)!
                newUser.address = userData[USER_ADDR] as? String
                newUser.email = userData[USER_EMAIL] as? String
                newUser.nationality = userData[USER_NAT] as? String
                newUser.identifier = "\(id)"
                newUser.phoneNumber = userData[USER_PHO] as? String
                newUser.falseAlarm = -1
                
                CoreDataManager.shared.saveContext()
            }
        }
            
    }
    
    private func createJSONDataAndSend(){
        var allDataToSend: [String:Any] = [:]
        if var userD = self.allUserData, var algs = self.allergies, var dis = self.diseases {
            userD.forEach{(k,v) in allDataToSend[k] = v}
            algs.forEach{(k,v) in allDataToSend[k] = v}
            dis.forEach{(k,v) in allDataToSend[k] = v}
            let path =  "users/"
            let ref = Database.database().reference(withPath: path)
            let id = self.userId!
            let idS = "325"
            let toSend = ref.child(idS)
            toSend.ref.updateChildValues(allDataToSend)
            
//            do {
//                let jsonData = try JSONSerialization.data(withJSONObject: allDataToSend, options: .prettyPrinted)
//                //send data
//                MGetAndPostData.postData(withData: jsonData)
//            }catch let error as Error {
//                print(error)
//            }
        }
    }
    
    
    //MARK:- ACTION
    @IBAction func registerAction(_ sender: Any) {
        self.saveInCoreData()
        self.createJSONDataAndSend()
    }
    

}

/*TO DO :
 * Check Network
 * Create JSON
 * Send data to the web service
 */
