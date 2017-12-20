//
//  RegisterOrLoginViewController.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 28/09/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import UIKit

class RegisterViewControllerFirst: UIViewController {
  
    //MARK:- OUTLET
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var nationality: UITextField!
    @IBOutlet weak var addressNAppt: UITextField!
    @IBOutlet weak var addressNStreet: UITextField!
    @IBOutlet weak var addressStreet: UITextField!
    @IBOutlet weak var addressPostCode: UITextField!
    @IBOutlet weak var addressCity: UITextField!
    
    //MARK:- VARIABLES
    public var id:Double!
    public var allUserData:[String:Any] = [:]
    
    //MARK:- BUTTON
    @IBOutlet weak var nextButton: UIButton!

    //MARK:- IOS FUNCTION
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let users = User.allUser(), users.count > 0 {
            self.chargeDataToPage(withUserData: users[0])
        }
        else {
            id = MyRandom.GenerateRandomId(withSize: SIZE_KEY_ID)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !isFormFilledCorrectly() {
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier ==  REGISTER_FIRST_SECOND) {
            if let registerViewControllerSecond:RegisterViewControllerSecond = segue.destination as? RegisterViewControllerSecond {
                registerViewControllerSecond.userId = self.id
                registerViewControllerSecond.allUserData = self.allUserData
            }
        }
    }


    //MARK:- PRIVATE FUNCTION
    private func isAllDataFilled() -> Bool {
        var res:Bool = true
        let subviews = self.view.subviews
        let exceptionsEmpty:[UITextField] = [self.addressNAppt]
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
        let res = VerifyDataFilling.isAnEmailAddress(withTextField: email)
        if res {
            return true
        }
        else {
            email.layer.borderColor = UIColor.red.cgColor
            email.layer.borderWidth = 1.0
            return false
        }
    }
    
    private func isFilledWithOnlyNumbers() -> Bool {
        let res = VerifyDataFilling.isFilledWithNumbers(withTextField: self.age) && VerifyDataFilling.isFilledWithNumbers(withTextField: self.addressPostCode)
        if res {
            return true
        }
        else {
            return false

        }
        
    }
    
    private func isFormFilledCorrectly() -> Bool {
        return (self.isAllDataFilled() && (isCorrectEmailFormat()) && (isFilledWithOnlyNumbers()))
    }
    
    private func createFullAddress() -> String {
        var fullAddress:String = ""
        if let nText = self.addressNAppt.text, nText != "" {
            fullAddress = "Appt n°"+nText + " "
        }
        if let addNS = self.addressNStreet.text,
        let addS = self.addressStreet.text,
        let addC = self.addressCity.text,
        let addP = self.addressPostCode.text {
            fullAddress = fullAddress + "Street N° " + addNS + " "
            fullAddress = fullAddress + addS + " "
            fullAddress = fullAddress + addC + " "
            fullAddress = fullAddress + addP
        }
        return fullAddress
    }
    
    private func createUserDictionary() {
        if let idS = id {
            /*if let newUser = User.UserOrNew(withIdentifier: "\(idS)"),*/
            if let ageS = self.age.text,
            let ageI = Int16(ageS) {
                let address = self.createFullAddress()
                //create dictionary
                self.allUserData.updateValue(self.firstName.text, forKey: USER_NAME)
                self.allUserData.updateValue(self.lastName.text, forKey: USER_LASTNAME)
                self.allUserData.updateValue(ageI, forKey: USER_AGE)
                self.allUserData.updateValue(self.email.text, forKey: USER_EMAIL)
                self.allUserData.updateValue(self.phoneNumber.text, forKey: USER_PHO)
                self.allUserData.updateValue(self.nationality.text, forKey: USER_NAT)
                self.allUserData.updateValue(address, forKey: USER_ADDR)
                self.allUserData.updateValue(-1, forKey: USER_FALSE_ALARM)
                self.allUserData.updateValue("325", forKey: USER_K)
            }
            
        }
    }
    
    private func testParser(withAddr addr : String) -> [String] {
        var tab:[String] = []
        var i:Int = 0
            for char in addr.characters {
                tab.append("")
                if char != "%" {
                    tab[i] = tab[i] + "\(char)"
                }
                else {
                    i = i + 1
                }
            }
        return tab
    }
    
    private func parserFullAdress(withUser user : User) -> [String]{
        var tab:[String] = []
        var i:Int = 0
        if let addresses = user.address {
            for char in addresses.characters {
                if char != "%" {
                    tab[i] = tab[i] + "\(char)"
                }
                else {
                    i = i + 1
                }
            }
        }
        return tab
    }
    
    private func chargeDataToPage(withUserData user : User) {
        self.firstName.text = user.firstName
        self.lastName.text = user.lastName
        self.email.text = user.email
        self.phoneNumber.text = user.phoneNumber
        self.nationality.text = user.nationality
        self.age.text = String(user.age)
        let addresses = self.parserFullAdress(withUser: user)
        self.addressNAppt.text = addresses[1]
        self.addressNStreet.text = addresses[3]
        self.addressStreet.text = addresses[4]
        self.addressPostCode.text = addresses[5]
        self.addressCity.text = addresses[6]
    }
    
    //MARK:- ACTION BUTTON
    
    @IBAction func nextPageAction(_ sender: Any) {
        if !isFormFilledCorrectly() {
            return
        }
        else {
            self.createUserDictionary()
            self.performSegue(withIdentifier: REGISTER_FIRST_SECOND, sender: "")
        }
    }

}

/*TO DO :
 * parse address
 * before sending the address : parse it to remove % and replace by space
 */
