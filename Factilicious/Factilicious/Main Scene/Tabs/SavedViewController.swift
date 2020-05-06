//
//  HomeViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 02/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import Firebase

class SavedViewController: UIViewController {
    
    var defaults = UserDefaults.standard
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    var uid: String!
    var facts = [String] ()
    var cleanFacts = [String] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        uid = defaults.string(forKey: "uid")
        ref = Database.database().reference()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        handle = ref?.child("Users").child(uid).child("Saved").observe(.childAdded, with: { (snapshot) in
            let fact = snapshot.value as! String
            self.facts.append(fact)
            self.cleanFacts = self.facts.removingDuplicates()
        })
    }
    

}

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()

        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
