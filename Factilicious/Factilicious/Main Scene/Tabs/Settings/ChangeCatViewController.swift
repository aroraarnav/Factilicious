//
//  ChangeCatViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 05/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

class ChangeCatViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var success: UIImageView!
    static var didComplete: Bool = false
    
    //Your function here
    func show() {
        label.isHidden = false
        success.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationPublisher.defaults.set("true", forKey: "already")
        label.isHidden = true
        success.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.show()
        }
        
        
    }
    
    override func viewDidAppear(_
        animated: Bool) {
        
        if CategoriesViewController.didComeBack == false {
            self.performSegue(withIdentifier: "changeCategories", sender: nil)
        }
        
        
    }

    @IBAction func donePressed(_ sender: Any) {
        ChangeCatViewController.didComplete = false
    }
    
}
