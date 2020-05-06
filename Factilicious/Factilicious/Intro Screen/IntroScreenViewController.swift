//
//  IntroScreenViewController.swift
//  Factilicious
//
//  Created by Arnav Arora on 01/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import paper_onboarding
import Firebase

class IntroScreenViewController: UIViewController {

    // Outlets
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var introView: IntroViewClass!
    
    
    // Handle the User defaults
    var userData = UserDefaults.standard
    
    
    @IBAction func getStartedPressed(_ sender: Any) {
        userData.set(true, forKey: "introCompleted")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if userData.bool(forKey: "isSignedIn") {
            self.performSegue(withIdentifier: "signedInSegue", sender: nil)
        }
        else if userData.bool(forKey: "introCompleted") == true {
            performSegue(withIdentifier: "mainSegue", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        introView.dataSource = self
        introView.delegate = self
        
        // Setup for Get Started Button
        getStartedButton.isHidden = true
        getStartedButton.layer.cornerRadius = 20
        getStartedButton.layer.borderColor = CGColor(srgbRed: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        getStartedButton.layer.backgroundColor = CGColor(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        getStartedButton.layer.borderWidth = 3.0
    }

    @objc func appMovedToBackground() {
        print("App moved to background!")
        do {
            try Auth.auth().signOut()
            print ("Success")
        } catch let err {
            print (err)
        }
    }
}

extension IntroScreenViewController: PaperOnboardingDelegate, PaperOnboardingDataSource {
    
    // Delegate Functions
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2 {
            getStartedButton.isHidden = false
        }
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index != 2 {
            if getStartedButton.isHidden == false {
                getStartedButton.isHidden = true
            }
        }
    }
    
    func onboardingConfigurationItem(_: OnboardingContentViewItem, index _: Int) {
        
    }
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        // Required Assets
        let bgThree = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let bgTwo =   #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        let bgOne =   #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)
        let descFont = UIFont(name: "AvenirNext-Regular", size: 18)
        
        let logo = UIImage(named: "logo-transparent")
        let icon = UIImage(named: "activeIndex")
        let bell = UIImage(named: "notification")
        let share = UIImage (named: "share")
        
        return [OnboardingItemInfo (informationImage: logo!, title: "Welcome To Factilicious", description: "Factilicious is the ultimate Fun Facts App! \n You can discover over 1000 amazing facts with this app. Save the facts you most like \n and show your friends!", pageIcon: icon!, color: bgTwo, titleColor: #colorLiteral(red: 0.8552109772, green: 0.07433366693, blue: 0.1143855852, alpha: 0.8505993151), descriptionColor: UIColor.black, titleFont: titleFont!, descriptionFont: descFont!),
                
                OnboardingItemInfo (informationImage: bell!, title: "New Fact Every Day", description: "You will get a new amazing fact every day with Factilicious. Simply allow Notifications and experience the magic!", pageIcon: icon!, color: bgOne, titleColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), descriptionColor: UIColor.white, titleFont: titleFont!, descriptionFont: descFont!),
                
                OnboardingItemInfo (informationImage: share!, title: "Share Facts Easily", description: "Factilicious allows you to share any fact you found with your family and friends, with a click of a button.", pageIcon: icon!, color: bgThree, titleColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), descriptionColor: UIColor.black, titleFont: titleFont!, descriptionFont: descFont!),
            ] [index]
    }
    
    
}
