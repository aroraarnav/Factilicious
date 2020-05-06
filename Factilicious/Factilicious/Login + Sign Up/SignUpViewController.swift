//
//  SignUpViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 02/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    var ref : DatabaseReference!
    var handle : DatabaseHandle!
    
    static var uid : String?
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpSpinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        ChangeCatViewController.didComplete = true
        signUpSpinner.isHidden = true
        ref = Database.database().reference()
        hideKeyboardWhenTappedAround()
        
        // Set up Nav Bar
        self.navigationController?.navigationBar.topItem?.title = "Welcome"
        // Apply corner Radius
        signUpButton.layer.cornerRadius = 25
        
        errorLabel.isHidden = true
        
        setUpElements()
    }
    

    @IBAction func signUpPressed(_ sender: Any) {
        
        signUpSpinner.isHidden = false
        signUpSpinner.startAnimating()
        // Validate the Fields
        let error = validateFields()
        
        if error != nil { // Error
            showError(error!)
            signUpSpinner.stopAnimating()
            self.signUpSpinner.isHidden = true
        } else {
            // Create Cleaned version of data
            
            let name = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the User
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    self.showError("We couldn't connect to our servers. Please try again later.")
                    self.signUpSpinner.stopAnimating()
                    self.signUpSpinner.isHidden = true
                } else {
                    self.signUpSpinner.stopAnimating()
                    self.signUpSpinner.isHidden = true
                    // Transition to the Categories Screen
                    
                    self.transitionToCategories()
                    // Add the user to the database
                    SignUpViewController.uid =  result!.user.uid
                    
                    self.defaults.set(result?.user.uid, forKey: "uid")
                    self.defaults.set(true, forKey: "isSignedIn")
                    
                    self.ref.child("Users").child(result!.user.uid).setValue(["Email" : email, "Name" : name, "Theme" : "yellow_background"])
                    
                }
            }
            
            
        }
        
    }
    
    @IBAction func termsPressed(_ sender: Any) {
    }
    @IBAction func privacyPolicyPressed(_ sender: Any) {
    }
    
    func setUpElements() {
        Utilities.styleTextFieldSignUp(nameTextField)
        Utilities.styleTextFieldSignUp(emailTextField)
        Utilities.styleTextFieldSignUp(passwordTextField)
    }
    
    
    func transitionToCategories () {
        performSegue(withIdentifier: "categoriesSegue", sender: nil)
    }
    
    // Check the fields and validate the data
    func validateFields () -> String? {
        // Check that all fields are filled in
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
            
        }
        
        // Check if the password and email are valid
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isEmailValid(cleanedEmail) == false {
            // Invalid
            return "The email address provided is invaild."
        }
        if Utilities.isPasswordValid(cleanedPassword) == false {
            // Not secure enough
            return "Please create a stronger password."
        }
        
        return nil
    }
    
    func showError (_ message:String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
