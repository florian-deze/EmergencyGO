//
//  RegisterViewControllerThird.swift
//  AdvancedProjectManagement
//
//  Created by florian deze on 23/10/2017.
//  Copyright © 2017 florian deze. All rights reserved.
//

import UIKit

class RegisterViewControllerThird: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    public var userId:Double?
    public var diseases:[String:String]?
    public var allergies:[String:String]?
    public var allUserData:[String:Any]?
    public var arrayElementName:[String] = []
    public var arrayElementDate:[String] = []
    
    
    @IBOutlet weak var thirdRegisterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //MARK:- DELEGATE METHODE
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayElementName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.thirdRegisterTableView.dequeueReusableCell(withIdentifier: "CellThird", for: indexPath) as? thirdRegisterTableViewCell {
            if self.arrayElementDate.count>0 {
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    //MARK:- PRIVATE FUNC
    
    private func getAllCells() -> [thirdRegisterTableViewCell] {
        
        var cells = [thirdRegisterTableViewCell]()
        
        for i in 0...thirdRegisterTableView.numberOfSections-1
        {
            if thirdRegisterTableView.numberOfRows(inSection: i)>0 {
                for j in 0...thirdRegisterTableView.numberOfRows(inSection: i)-1
                {
                    if let cell = thirdRegisterTableView.cellForRow(at: IndexPath(row: j, section: i)) as? thirdRegisterTableViewCell{
                        cells.append(cell)
                    }
                
                }
            }
        }
        return cells
    }
    
    private func retreiveDataFromCell() -> [String:String] {
        var allData:[String:String] = [:]
        var tmpAllAllergies = ""
        let cells = self.getAllCells()
        for cell in cells {
            if let name = cell.nameAllergies.text {
                tmpAllAllergies = tmpAllAllergies + name + " ; "
            }
        }
        allData.updateValue(tmpAllAllergies, forKey: "Allergies")
        return allData
    }
    
    //MARK:- ACTION
    
    @IBAction func addCell(_ sender: Any) {
        
        self.arrayElementName.append("")
        self.arrayElementDate.append("")
        
        DispatchQueue.main.async(execute: { () -> Void in
            //reload your tableView
            self.thirdRegisterTableView.reloadData()
        })
    }
    
    @IBAction func nextPagetest(_ sender: Any) {
        //print(self.retreiveDataFromCell())
        self.allergies = self.retreiveDataFromCell()
        self.performSegue(withIdentifier: REGISTER_THIRD_FORTH, sender: "")
    }
    
    //MARK:- SEND DATA To Next PAGE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if (segue.identifier ==  REGISTER_THIRD_FORTH) {
            if let registerViewControllerForth:RegisterViewControllerForth = segue.destination as? RegisterViewControllerForth {
                registerViewControllerForth.userId = self.userId
                registerViewControllerForth.diseases = self.diseases
                registerViewControllerForth.allergies = self.allergies
                registerViewControllerForth.allUserData = self.allUserData
            }
        }
    }

    

}
