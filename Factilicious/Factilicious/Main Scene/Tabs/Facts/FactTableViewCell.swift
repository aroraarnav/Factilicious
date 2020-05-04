//
//  FactTableViewCell.swift
//  Factilicious
//
//  Created by Arnav Arora on 04/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

class FactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var factLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
