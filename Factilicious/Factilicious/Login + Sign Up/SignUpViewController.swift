//
//  SignUpViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 02/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up Nav Bar
    self.navigationController?.navigationBar.topItem?.title = "Welcome"
        // Apply corner Radius
        signUpButton.layer.cornerRadius = 25
    }
    

    @IBAction func signUpPressed(_ sender: Any) {
    }
    
    @IBAction func termsPressed(_ sender: Any) {
    }
    @IBAction func privacyPolicyPressed(_ sender: Any) {
    }
    
}
