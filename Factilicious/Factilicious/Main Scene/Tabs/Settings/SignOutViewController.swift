//
//  ViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 05/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import Firebase

class SignOutViewController: UIViewController {
    
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spinner.startAnimating()
        defaults.set(false, forKey: "isSignedIn")
        
        do {
            try Auth.auth().signOut()
            print ("Success")
        } catch let err {
            print (err)
        }
        
        let delay = 3 // seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(delay)) {
            self.spinner.stopAnimating()
            self.performSegue(withIdentifier: "signOutSegue", sender: nil)
        }
    }
    
}
