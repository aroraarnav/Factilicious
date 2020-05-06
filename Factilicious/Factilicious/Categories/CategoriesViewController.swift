//
//  CategoriesViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 03/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import Firebase

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    static var didComeBack:Bool? = false
    
    var defaults = UserDefaults.standard
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell") as! CategoriesTableViewCell
        
        if isChecked {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        
        cell.selectionStyle = .none
        cell.categoryLabel.text = dataModel[indexPath.row]
        cell.categoryImage.image = UIImage (named: dataModel[indexPath.row])
        cell.categoryImage.layer.cornerRadius = cell.categoryImage.bounds.width / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let cell = tableView.dequeueReusableCell(withIdentifier: "categoriesCell") as! CategoriesTableViewCell
        
        
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark {
            CategoriesViewController.userCategories = CategoriesViewController.userCategories.filter { $0 != dataModel[indexPath.row] }
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            isChecked = false
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            isChecked = true
            CategoriesViewController.userCategories.append(dataModel[indexPath.row])
        }
    }
    

    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    var isChecked : Bool! = false
    let dataModel = ["Animals", "Cars", "Sports", "Math", "Food"]
    var ref : DatabaseReference?
    static var userCategories = [String] ()
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print (ChangeCatViewController.didComplete)
        CategoriesViewController.userCategories = [String] ()
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        confirmButton.layer.cornerRadius = 25
        confirmButton.layer.borderColor = confirmButton.titleColor(for: .normal)?.cgColor
        confirmButton.layer.borderWidth = 1
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        if CategoriesViewController.userCategories.count < 2 {
            createAlert(title: "Notice", message: "Please select at least 2 categories of your choice.")
        } else {
            
            if ChangeCatViewController.didComplete == false {
                // Store Preferences in Database
                    let uid = defaults.string(forKey: "uid")
                
                    ref?.child("Users").child(uid!).child("Categories").setValue(nil)
                ref?.child("Users").child(uid!).child("Categories").setValue([CategoriesViewController.userCategories])
                
                    ChangeCatViewController.didComplete = true
                
                    // Transition To Settings
                    CategoriesViewController.didComeBack = true
                    navigationController?.popViewController(animated: true)
                    dismiss(animated: true, completion: nil)
                    
                    
                        
            } else {
                // Store Preferences in Database
                    let uid = defaults.string(forKey: "uid")
                ref?.child("Users").child(uid!).child("Categories").setValue([CategoriesViewController.userCategories])
                    // Transition To Home Screen
                    
                    self.performSegue(withIdentifier: "signUpSegue", sender: nil)
                
                    ChangeCatViewController.didComplete = false
                    
            }
            
                
        }
    }
    
    public func createAlert (title:String, message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
   

}
