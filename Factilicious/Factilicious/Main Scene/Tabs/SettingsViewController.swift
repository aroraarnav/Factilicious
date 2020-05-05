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
    
    @IBOutlet weak var topLabel: UILabel!
    
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
        
        // Get Name from Database
        let uid = defaults.string(forKey: "uid")
        
        handle = ref?.child("Users").child(uid!).child("Name").observe(.value, with: { (snapshot) in
            let name = snapshot.value as! String
            self.topLabel.text = name
            self.topLabel.layer.borderWidth = 1
            self.topLabel.layer.borderColor = self.topLabel.textColor.cgColor
            self.topLabel.layer.cornerRadius = 25
        })
        
    }
 

}
