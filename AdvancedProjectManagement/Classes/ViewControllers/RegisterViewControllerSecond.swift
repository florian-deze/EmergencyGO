//
//  RegisterViewControllerSecond.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 09/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import UIKit

class RegisterViewControllerSecond: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- OUTLET
    
    @IBOutlet weak var secondRegisterTableView: UITableView!
    
    
    //MARK:- VARIABLES
    public var userId:Double?
    public var diseases:[String:String] = [:]
    public var allUserData:[String:Any]?
    public var arrayElementName:[String] = []
    public var arrayElementDate:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- DELEGATE METHODE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayElementName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.secondRegisterTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? secondRegisterTableViewCell {
            if self.arrayElementDate.count>0 {
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    //MARK:- PRIVATE FUNC
    
    private func getAllCells() -> [secondRegisterTableViewCell] {
        
        var cells = [secondRegisterTableViewCell]()
        
        for i in 0...secondRegisterTableView.numberOfSections-1
        {
            if secondRegisterTableView.numberOfRows(inSection: i)>0 {
            for j in 0...secondRegisterTableView.numberOfRows(inSection: i)-1
            {
                if let cell = secondRegisterTableView.cellForRow(at: IndexPath(row: j, section: i)) as? secondRegisterTableViewCell{
                    cells.append(cell)
                }
                
            }
            }
        }
        return cells
    }
    
    private func retreiveDataFromCell() -> [String:String] {
        var allData:[String:String] = [:]
        var tmpAllMedRecords = ""
        let cells = self.getAllCells()
        for cell in cells {
            if let name = cell.nameTextField.text, let dateT = cell.dateTextField.text {
                tmpAllMedRecords = tmpAllMedRecords + "{" + name + ";" + dateT + "}" + " ; "

            }
        }
        allData.updateValue(tmpAllMedRecords, forKey: MED)
        return allData
    }
    
    //MARK:- ACTION
    
    @IBAction func addCell(_ sender: Any) {
        
        self.arrayElementName.append("")
        self.arrayElementDate.append("")
        
        DispatchQueue.main.async(execute: { () -> Void in
            //reload your tableView
            self.secondRegisterTableView.reloadData()
        })
    }
    
    @IBAction func nextPagetest(_ sender: Any) {
        //print(self.retreiveDataFromCell())
        self.diseases = self.retreiveDataFromCell()
        self.performSegue(withIdentifier: REGISTER_SECOND_THIRD, sender: "")
    }
    
    //MARK:- SEND DATA To Next PAGE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier ==  REGISTER_SECOND_THIRD) {
            if let registerViewControllerThird:RegisterViewControllerThird = segue.destination as? RegisterViewControllerThird {
                registerViewControllerThird.userId = self.userId
                registerViewControllerThird.diseases = self.diseases
                registerViewControllerThird.allUserData = self.allUserData
            }
        }
    }
    

}
