//
//  LoginViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 02/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginSpinner.isHidden = true
        hideKeyboardWhenTappedAround()
        // Set up Navbar
        self.navigationController?.navigationBar.topItem?.title = "Welcome"
        
        // Apply Corner Radius
        loginButton.layer.cornerRadius = 25
        
        errorLabel.isHidden = true
        
        setUpElements()
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        loginSpinner.isHidden = false
        loginSpinner.startAnimating()
        // Check if the fields are empty
        if
        emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        
            loginSpinner.stopAnimating()
            loginSpinner.isHidden = true
            
            errorLabel.text = "Please fill in all fields."
            errorLabel.isHidden = false
        } else if Utilities.isEmailValid(emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false {
            
            loginSpinner.stopAnimating()
            loginSpinner.isHidden = true
            errorLabel.text = "The email is not correctly formatted."
            errorLabel.isHidden = false
            
            
        } else {
            // Clean the data
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
                if err != nil {
                    self.loginSpinner.stopAnimating()
                    self.loginSpinner.isHidden = true
                    self.errorLabel.text = "The Email/Password is incorrect."
                    self.errorLabel.isHidden = false
                } else {
                    self.loginSpinner.stopAnimating()
                    self.transitionToHome ()
                }
            }
        }
    }
    
    @IBAction func termsPressed(_ sender: Any) {
    }
    
    @IBAction func privacyPressed(_ sender: Any) {
    }
    
    func transitionToHome () {
        print ("Log In Successful")
    }
    func setUpElements() {
        Utilities.styleTextFieldLogin(emailTextField)
        Utilities.styleTextFieldLogin(passwordTextField)
    }
}
