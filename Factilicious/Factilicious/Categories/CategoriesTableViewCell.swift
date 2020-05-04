//
//  CategoriesTableViewCell.swift
//  Factilicious
//
//  Created by Arnav Arora on 03/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
    }

}
