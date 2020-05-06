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
    @IBOutlet weak var refresh: UIButton!
    @IBOutlet weak var gettingFacts: UILabel!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var factSpinner: UIActivityIndicatorView!
    
    static var name: String?
    var uidUser : String?
    var fact : String!
    var shuffled = [String] ()
    var facts = [String] ()
    var categories = [String] ()
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    var defaults = UserDefaults.standard
    private var refreshControl = UIRefreshControl()
    var random = Int.random(in: 0...IntroScreenViewController.shuffledFacts.count - 1)
    
    // Configure Control
    
    static var backgroundImage : String?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let uid = defaults.string(forKey: "uid")
        uidUser = uid
        
        // Get the name
        handle = ref?.child("Users").child(uid!).child("Name").observe(.value, with: { (snapshot) in
            FactsViewController.name = snapshot.value as? String
        })
        // Set the Background
        
        handle = ref?.child("Users").child(uid!).child("Theme").observe(.value, with: { (snapshot) in
            let theme = snapshot.value as! String
            
            FactsViewController.backgroundImage = theme
            self.TableView.backgroundView = UIImageView(image: UIImage(named: FactsViewController.backgroundImage!))
            
            })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        refresh.isHidden = true
        factSpinner.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        
        // Implement Refresh Control
        refreshControl = UIRefreshControl ()
        TableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshFacts(_:)), for: .valueChanged)
        
        factSpinner.startAnimating()
        self.tabBarController?.tabBar.isHidden = true
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
            self.gettingFacts.isHidden = true
            self.tabBarController?.tabBar.isHidden = false
            self.refresh.isHidden = false
            
            // Refresh to prevent White
            self.refreshFacts(self)
            })
        
    }

    @IBAction func refresh(_ sender: Any) {
        
        // Rotate the button
        UIView.animate(withDuration: 0.5) { () -> Void in
          self.refresh.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        self.refresh.transform = CGAffineTransform(scaleX: 2,y: 2)
        }

        UIView.animate(withDuration: 0.5, delay: 0.25, options: UIView.AnimationOptions.curveEaseIn, animations: { () -> Void in
          self.refresh.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: nil)
        
        // self.refresh.transform = .identity
        
        refreshFacts(self)
        
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
        return 280
        
    }
    
    @objc func refreshFacts(_ sender: Any) {
        // Refresh Facts
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        self.refreshControl.tintColor = UIColor.black
        self.refreshControl.attributedTitle = NSAttributedString(string: "Mixing It Up...", attributes: attributes)
        
        
        
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
        ref?.child("Users").child(uidUser!).child("Saved").childByAutoId().setValue(fact)
    }
    
    func didTapShare(fact: String) {
        // Instantiate Share View Controller
        let shareString = "Today, I got to know about this cool fact on the Factilicious App!\n\n" + fact as Any
        let shareVC = UIActivityViewController (activityItems: [shareString], applicationActivities: nil)
        shareVC.popoverPresentationController?.sourceView = self.view
        
        // Present it
        self.present(shareVC, animated: true, completion: nil)
    }
    
    
    
}
