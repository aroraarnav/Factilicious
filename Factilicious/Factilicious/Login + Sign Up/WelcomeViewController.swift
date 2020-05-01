//
//  WelcomeViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 01/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 25
        signUpButton.layer.cornerRadius = 25
    }
    

}
