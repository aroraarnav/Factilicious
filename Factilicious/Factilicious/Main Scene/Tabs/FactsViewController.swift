//
//  FactsViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 03/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit

class FactsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var collectionView: UICollectionView?
    let models = ["Animals", "Food", "Sports", "Science", "Math", "Cars"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up collectionView
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 75, height: 75)
        layout.sectionInset = UIEdgeInsets (top: 0, left: 0, bottom: 0, right: 0)
            
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        // Register the collection View
        collectionView?.register(CircleCollectionViewCell.self, forCellWithReuseIdentifier: CircleCollectionViewCell.identifier)
        
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = .white
        
        guard let myCollection = collectionView else { return }
        view.addSubview(myCollection)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect (x: 0, y: 75, width: view.frame.size.width, height: 75).integral
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleCollectionViewCell.identifier, for: indexPath) as! CircleCollectionViewCell
        //CircleCollectionViewCell.myImageView.tag = indexPath.item
        //CircleCollectionViewCell.myImageView.addTarget(self, action: #selector(self.buttonClicked), for: .touchUpInside)
    
        cell.configure(with: models [indexPath.row])
        return cell
    }
    
    /*@objc func buttonClicked (_ sender: UIButton) {
        if sender.tag == 0 {
            print ("Animals")
        }
    } */
    
    
}
