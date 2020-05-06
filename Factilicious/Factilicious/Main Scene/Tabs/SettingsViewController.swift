//
//  SettingsViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 03/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    var defaults = UserDefaults.standard
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Initialise reference
        ref = Database.database().reference()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        CategoriesViewController.didComeBack = false

    }
    
    
}
