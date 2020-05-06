//
//  SavedTableViewCell.swift
//  Factilicious
//
//  Created by Arnav Arora on 06/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

protocol SaveCellDelegate {
    func didPressShare (fact: String)
}
class SavedTableViewCell: UITableViewCell {
    
    var delegate: SaveCellDelegate?

    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func sharePressed(_ sender: Any) {
        delegate?.didPressShare(fact: factLabel.text!)
    }
}
