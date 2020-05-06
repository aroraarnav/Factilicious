//
//  FactTableViewCell.swift
//  Factilicious
//
//  Created by Arnav Arora on 04/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

protocol FactCellDelegate {
    func didTapSave (fact: String)
    func didTapShare (fact:String)
}

class FactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var factLabel: UILabel!
    var delegate : FactCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        saveButton.setImage(UIImage(named: "empty-heart"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        // Create Like Animation
        
        UIView.transition(with: sender as UIView, duration: 0.4, options: .transitionFlipFromRight, animations: {
                   sender.setImage(UIImage(named: "filled-heart"), for: .normal)
               }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
        UIView.transition(with: sender as UIView, duration: 0.2, options: .transitionFlipFromLeft, animations: {
                sender.setImage(UIImage(named: "empty-heart"), for: .normal)
            }, completion: nil)
        }
        
        
        
        delegate?.didTapSave(fact: factLabel.text!)
    }
    @IBAction func shareButtonPressed(_ sender: Any) {
        delegate?.didTapShare(fact: factLabel.text!)
    }
}
