//
//  ThemesViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 05/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import Firebase

class ThemesViewController: UIViewController {
    
    var ref : DatabaseReference?
    var defaults = UserDefaults.standard
    var uid: String?
    
    @IBOutlet weak var yellowTheme: UIButton!
    @IBOutlet weak var pinkTheme: UIButton!
    @IBOutlet weak var turquoiseTheme: UIButton!
    @IBOutlet weak var greenTheme: UIButton!
    @IBOutlet weak var blueTheme: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Init uid
        uid = defaults.string(forKey: "uid")
        // Init ref
        ref = Database.database().reference()
        // Corner Radii
        yellowTheme.layer.cornerRadius = 30
        turquoiseTheme.layer.cornerRadius = 30
        pinkTheme.layer.cornerRadius = 30
        greenTheme.layer.cornerRadius = 30
        blueTheme.layer.cornerRadius = 30
        
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func bluePressed(_ sender: Any) {
        if CheckInternet.Connection() {
            
            ref?.child("Users").child(uid!).child("Theme").setValue("blue_background")
            self.performSegue(withIdentifier: "themeSegue", sender: nil)
        } else {
            
        }
    }
    
    @IBAction func yellowPressed(_ sender: Any) {
        if CheckInternet.Connection() {
            
            ref?.child("Users").child(uid!).child("Theme").setValue("yellow_background")
            self.performSegue(withIdentifier: "themeSegue", sender: nil)
        } else {
            
        }
    }
    
    @IBAction func pinkPressed(_ sender: Any) {
        if CheckInternet.Connection() {
            ref?.child("Users").child(uid!).child("Theme").setValue("pink_background")
            self.performSegue(withIdentifier: "themeSegue", sender: nil)
        } else {
            
        }
    }
    
    @IBAction func turquoisePressed(_ sender: Any) {
        if CheckInternet.Connection() {
            ref?.child("Users").child(uid!).child("Theme").setValue("turquoise_background")
            self.performSegue(withIdentifier: "themeSegue", sender: nil)
        } else {
            
        }
    }
    @IBAction func greenPressed(_ sender: Any) {
        if CheckInternet.Connection() {
            ref?.child("Users").child(uid!).child("Theme").setValue("green_background")
            self.performSegue(withIdentifier: "themeSegue", sender: nil)
        } else {
            
        }
    }
    
}
