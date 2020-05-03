//
//  CircleCollectionViewCell.swift
//  Factilicious
//
//  Created by Arnav Arora on 03/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

class CircleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CircleCollectionViewCell"
    let myImageView: UIButton = {
        let imageView = UIButton ()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 37.5
        imageView.backgroundColor = .blue
        
        return imageView
        
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(myImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myImageView.frame = contentView.bounds
    }
    
    public func configure (with name:String) {
        let btnImage = UIImage(named: name)
        myImageView.setImage (btnImage, for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myImageView.setImage (nil, for: .normal)
    }
}

