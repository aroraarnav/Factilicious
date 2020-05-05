//
//  FactsViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 03/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import Firebase

class FactsViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var factSpinner: UIActivityIndicatorView!
    
    var fact : String!
    var shuffled = [String] ()
    var facts = [String] ()
    var categories = [String] ()
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    var defaults = UserDefaults.standard
    private var refreshControl = UIRefreshControl()
    
    // Configure Control
    
    static var backgroundImage : String?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let uid = defaults.string(forKey: "uid")
        
        // Set the Background
        
        handle = ref?.child("Users").child(uid!).child("Theme").observe(.value, with: { (snapshot) in
            let theme = snapshot.value as! String
            FactsViewController.backgroundImage = theme
            self.TableView.backgroundView = UIImageView(image: UIImage(named: FactsViewController.backgroundImage!))
            })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Implement Refresh Control
        refreshControl = UIRefreshControl ()
        TableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshFacts(_:)), for: .valueChanged)
        
        factSpinner.startAnimating()
        let uid = defaults.string(forKey: "uid")
        
        // Init Reference
        ref = Database.database().reference()
        
        //Get user Categories and Facts
            
        handle = ref?.child("Users").child(uid!).child("Categories").child("0").observe(.childAdded, with: { (snapshot) in
                let category = snapshot.value as! String
                
                self.handle = self.ref?.child("Facts").child(category).observe(.childAdded, with: { (facts) in
                    let fact = facts.value as! String
                    self.facts.append(fact)
                    self.shuffled = self.facts.shuffled()
                    self.TableView.reloadData()
                    
                    
                })
                
            self.factSpinner.stopAnimating()
            self.factSpinner.isHidden = true
            self.bgView.isHidden = true
            })
        
    }
    
    
    
}
    

extension FactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shuffled.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FactTableViewCell") as! FactTableViewCell
        cell.selectionStyle = .none
        // Set the delegate
        
        cell.delegate = self
        
        cell.factLabel.text = shuffled [indexPath.row]
        fact = shuffled [indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
        
    }
    
    @objc private func refreshFacts(_ sender: Any) {
        // Refresh Facts
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Getting New Facts...", attributes: nil)
        // Reshuffle
        shuffled = shuffled.shuffled()
        
        TableView.reloadData()
        
        let when = DispatchTime.now() + 1 // change to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.refreshControl.endRefreshing()
        }
    }
}

extension FactsViewController: FactCellDelegate {
    func didTapSave(fact: String) {
        
    }
    
    func didTapShare(fact: String) {
        // Instantiate Share View Controller
        let shareString = "Today, I got to know about this cool fact on the Factilicious App!\n\n " + fact as Any
        let shareVC = UIActivityViewController (activityItems: [shareString], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = self.view
        
        // Present it
        self.present(shareVC, animated: true, completion: nil)
    }
    
    
    
}
