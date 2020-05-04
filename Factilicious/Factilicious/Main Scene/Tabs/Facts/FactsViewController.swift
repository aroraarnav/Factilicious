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

    
    @IBOutlet weak var TableView: UITableView!
    
    var shuffled = [String] ()
    var facts = [String] ()
    var categories = [String] ()
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    var defaults = UserDefaults.standard
    
    static var backgroundImage : String?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // Set the Background
        
        if LoginViewController.didLogin {
        
        handle = ref?.child("Users").child(LoginViewController.uid!).child("Theme").observe(.value, with: { (snapshot) in
            let theme = snapshot.value as! String
            FactsViewController.backgroundImage = theme
            self.TableView.backgroundView = UIImageView(image: UIImage(named: FactsViewController.backgroundImage!))
            })
        } else {
        handle = ref?.child("Users").child(SignUpViewController.uid!).child("Theme").observe(.value, with: { (snapshot) in
            let theme = snapshot.value as! String
            FactsViewController.backgroundImage = theme
            print (theme)
            self.TableView.backgroundView = UIImageView(image: UIImage(named: FactsViewController.backgroundImage!))
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Init Reference
        ref = Database.database().reference()
        
        //Get user Categories
        if LoginViewController.didLogin {
            
            handle = ref?.child("Users").child(LoginViewController.uid!).child("Categories").child("0").observe(.childAdded, with: { (snapshot) in
                let category = snapshot.value as! String
                
                self.handle = self.ref?.child("Facts").child(category).observe(.childAdded, with: { (facts) in
                    let fact = facts.value as! String
                    self.facts.append(fact)
                    self.shuffled = self.facts.shuffled()
                    self.TableView.reloadData()
                    
                    
                })
                
            })
        } else {
            handle = ref?.child("Users").child(SignUpViewController.uid!).child("Categories").child("0").observe(.childAdded, with: { (snapshot) in
                let category = snapshot.value as! String
                self.categories.append(category)
                
                self.handle = self.ref?.child("Facts").child(category).observe(.childAdded, with: { (facts) in
                    let fact = facts.value as! String
                    self.facts.append(fact)
                    self.shuffled = self.facts.shuffled()
                    self.TableView.reloadData()
                    
                    
                })
            })
        }
    }
    
    
    
}
    

extension FactsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shuffled.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FactTableViewCell") as! FactTableViewCell
        cell.selectionStyle = .none
        cell.factLabel.text = shuffled [indexPath.row]
        
        if FactsViewController.backgroundImage == "red_background_color" {
            cell.factLabel.textColor = UIColor.white
        } else if FactsViewController.backgroundImage == "blue_background_color" {
            cell.factLabel.textColor = UIColor.white
            // Change Color of Buttons
        } else {
            cell.factLabel.textColor = UIColor.black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
        
    }
    
}
