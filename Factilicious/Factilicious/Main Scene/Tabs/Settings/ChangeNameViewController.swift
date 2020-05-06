//
//  ChangeNameViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 06/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import Firebase

class ChangeNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    let defaults = UserDefaults.standard
    var uid: String!
    var ref: DatabaseReference?
    let name = FactsViewController.name
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        hideKeyboardWhenTappedAround()
        uid = defaults.string(forKey: "uid")
        ref = Database.database().reference()
        //Set up elements
        confirmButton.layer.cornerRadius = 25
        Utilities.styleTextFieldSignUp(nameTextField)
        
        nameTextField.text = name

    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmPressed(_ sender: Any) {
        
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" || nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != nil {
            ref?.child("Users").child(uid).child("Name").setValue(nameTextField.text)
            
            // Segue
            performSegue(withIdentifier: "nameSegue", sender: nil)
            
            
        } else {
            errorLabel.alpha = 1
        }
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
