//
//  NotificationsViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 07/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

class NotificationsViewController: UIViewController {

    @IBOutlet weak var notiBell: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        notiBell.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
        settings.layer.cornerRadius = 25
        
    }
    @IBOutlet weak var settings: UIButton!
    

    @IBAction func settingsPressed(_ sender: Any) {
            
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        
    }
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
