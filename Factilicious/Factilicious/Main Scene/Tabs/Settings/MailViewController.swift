//
//  MailViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 05/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import MessageUI

class MailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.isHidden = true
        statusLabel.isHidden = true
        showMailComposer ()
    }
    
    
    func showMailComposer () {
        guard MFMailComposeViewController.canSendMail() else {
            print ("Hello")
            let alert = UIAlertController(title: "Notice", message: "Sorry, mail has not been set up on this device. Please email aroraarnav2005@gmail.com to submit your feedback.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true) {
                    self.dismiss(animated: true, completion: nil)
                }
                self.present(alert, animated: true, completion: nil)
            }))
            return
        }
        
        let composer = MFMailComposeViewController ()
        composer.mailComposeDelegate = self
        composer.setSubject("Feedback")
        composer.setToRecipients(["aroraarnav2005@gmail.com"])
        composer.setMessageBody("Here is my feedback for the Factilicious App:", isHTML: false)
        
        present(composer, animated: true, completion: nil)
    }
    
    @IBAction func donePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        if let _ = error {
            
            let alert = UIAlertController(title: "Error", message: "There was an error, Please try again later.", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: { (action) in
                controller.dismiss(animated: true) {
                    self.dismiss(animated: true, completion: nil)
                }
            }))
            
            self.present(alert, animated: true, completion: nil)

            return
        }
        
        switch result {
        case .cancelled:
            self.dismiss(animated: true, completion: nil)
            
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
            
        case .sent:
            self.dismiss(animated: true, completion: nil)
            image.image = UIImage(named: "success")
            image.isHidden = false
            statusLabel.isHidden = false
            statusLabel.textColor = UIColor.green
            statusLabel.text = "Success! Your message has been sent. You will reveive a reply shortly."
        case .saved:
            self.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
            
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
            
        case .failed:
            self.dismiss(animated: true, completion: nil)
            image.image = UIImage(named: "failiure")
            image.isHidden = false
            statusLabel.isHidden = false
            statusLabel.textColor = UIColor.red
            statusLabel.text = "Sorry, something went wrong. Your message could not be sent."
        
        }
    }
}
