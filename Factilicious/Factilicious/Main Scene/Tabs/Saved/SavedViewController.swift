//
//  HomeViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 02/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import Firebase

class SavedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cleanFacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "savedCell") as! SavedTableViewCell
        
        cell.factLabel.text = cleanFacts[indexPath.row]
        cell.selectionStyle = .none
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    
    @IBOutlet weak var noneView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveSpinner: UIActivityIndicatorView!
    
    var defaults = UserDefaults.standard
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    var uid: String!
    var facts = [String] ()
    var cleanFacts = [String] ()

    override func viewDidLoad() {
        super.viewDidLoad()
        noneView.isHidden = false
        tableView.isHidden = true
        saveSpinner.startAnimating()
        
        // Assign delegate and DataSource
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Init UID and REF
        uid = defaults.string(forKey: "uid")
        ref = Database.database().reference()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // Bg
        self.tableView.backgroundView = UIImageView(image: UIImage(named: FactsViewController.backgroundImage!))
        handle = ref?.child("Users").child(uid).child("Saved").observe(.childAdded, with: { (snapshot) in
            
            let fact = snapshot.value as! String
                self.facts.append(fact)
                self.cleanFacts = self.facts.removingDuplicates().reversed()
                    
                self.tableView.reloadData()
                self.noneView.isHidden = true
                self.tableView.isHidden = false
                self.saveSpinner.stopAnimating()
                self.saveSpinner.isHidden = true
            
        })
    }
    
    @IBAction func deleteAllPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Notice", message: "Are you sure you want to delete all of your favourites? This action cannot be undone.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "Delete", style: .destructive, handler: { (action) in
            self.ref?.child("Users").child(self.uid).child("Saved").setValue(nil)
            alert.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "deleteSegue", sender: nil)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        present(alert, animated: true, completion: nil)
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

extension SavedViewController: SaveCellDelegate {
    
    func didPressShare(fact: String) {
        // Instantiate Share View Controller
        let shareString = "I want to share this awesome fact with you!\n\n" + fact as Any
        let shareVC = UIActivityViewController (activityItems: [shareString], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = self.view
        
        // Present it
        self.present(shareVC, animated: true, completion: nil)
    }
    
    
}
