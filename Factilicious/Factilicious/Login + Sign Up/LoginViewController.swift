//
//  LoginViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 02/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        // Set up Navbar
        self.navigationController?.navigationBar.topItem?.title = "Welcome"
        
        // Apply Corner Radius
        loginButton.layer.cornerRadius = 25
        
        errorLabel.isHidden = true
        
        setUpElements()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
    }
    
    @IBAction func termsPressed(_ sender: Any) {
    }
    
    @IBAction func privacyPressed(_ sender: Any) {
    }
    
    func setUpElements() {
        Utilities.styleTextFieldLogin(emailTextField)
        Utilities.styleTextFieldLogin(passwordTextField)
    }
}
