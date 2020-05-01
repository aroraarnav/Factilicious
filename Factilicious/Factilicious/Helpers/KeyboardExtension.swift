//
//  KeyboardExtension.swift
//  Ortho Consult
//
//  Created by Arnav Arora on 09/04/20.
//  Copyright © 2020 Arnav Arora. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround () {
        let tapGesture = UITapGestureRecognizer (target:self, action: #selector(hideKeyboard))
        
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
        
        func getText () {
            
        }
    }
}
