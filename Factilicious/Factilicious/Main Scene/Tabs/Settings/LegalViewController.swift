//
//  LegalViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 07/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

class LegalViewController: UIViewController {
    
    @IBOutlet weak var tAndC: UIButton!
    @IBOutlet weak var privacy: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tAndC.layer.cornerRadius = 25
        privacy.layer.cornerRadius = 25
        
    }

    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func termsPressed(_ sender: Any) {
        self.present(WebPage.termsSvc, animated: true, completion: nil)
    }
    @IBAction func privacyPressed(_ sender: Any) {
        self.present(WebPage.privacySvc, animated: true, completion: nil)
    }
}
