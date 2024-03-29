//
//  LoginViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 02/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let webPage = WebPage ()
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginSpinner: UIActivityIndicatorView!
    static var uid:String?
    static var didLogin = false
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
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
                    self.loginSpinner.isHidden = true
                    LoginViewController.didLogin = true
                    LoginViewController.uid =  result?.user.uid
                    self.defaults.set(result?.user.uid, forKey: "uid")
                    self.defaults.set(true, forKey: "isSignedIn")
                    ChangeCatViewController.didComplete = false
                    self.transitionToHome ()
                    
                }
            }
        }
    }
    
    @IBAction func termsPressed(_ sender: Any) {
        self.present(WebPage.termsSvc, animated: true, completion: nil)
    }
    
    @IBAction func privacyPressed(_ sender: Any) {
        self.present(WebPage.privacySvc, animated: true, completion: nil)
    }
    
    func transitionToHome () {
        performSegue(withIdentifier: "loginSegue", sender: nil)
        
    }
    func setUpElements() {
        Utilities.styleTextFieldLogin(emailTextField)
        Utilities.styleTextFieldLogin(passwordTextField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

