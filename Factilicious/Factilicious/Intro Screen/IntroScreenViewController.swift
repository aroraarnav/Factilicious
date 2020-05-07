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
    
    

    let notificationPublisher = NotificationPublisher ()
    
    private func requestNotifications () {
        
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        
        
        
        center.requestAuthorization(options: options) { (granted, error) in
            if let error = error {
                print (error.localizedDescription)
            }
            
        }
        
        
        
    }
    // Outlets
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var loaderView: UIView!
    @IBOutlet weak var introView: IntroViewClass!
    
    // Handle the User defaults
    var randInt: Int?
    var ref: DatabaseReference?
    var handle: DatabaseHandle?
    static var shuffledFacts = [String?] ()
    var notiFacts  = [String] ()
    var userData = UserDefaults.standard
    
    @IBOutlet weak var factSpinner: UIActivityIndicatorView!
    
    @IBAction func getStartedPressed(_ sender: Any) {
        userData.set(true, forKey: "introCompleted")
        userData.set(true, forKey: "willReview")
        requestNotifications ()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print ("hello")
        super.viewDidAppear(true)
        IntroScreenViewController.shuffledFacts = [String] ()
        // Set it up
        // // // // // // // // // // //
        handle = ref?.child("Facts").child("General").observe(.childAdded, with: { (snapshot) in
            
            
            let fact = snapshot.value as? String
            self.notiFacts.append(fact!)
            IntroScreenViewController.shuffledFacts = self.notiFacts.shuffled()
            self.randInt = Int.random(in: 0...IntroScreenViewController.shuffledFacts.count - 1)
            
            
            
            if self.userData.bool(forKey: "isSignedIn") {
                
                self.performSegue(withIdentifier: "signedInSegue", sender: nil)
            }
            else if self.userData.bool(forKey: "introCompleted") == true {
                self.performSegue(withIdentifier: "mainSegue", sender: nil)
                
                
            }
            
            self.loaderView.isHidden = true
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        factSpinner.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        loaderView.isHidden = false
        
        // Set Up Notifications
        ref = Database.database().reference()
        
        let notiTime = userData.integer(forKey: "notiTime")
        
        if notiTime == 0 {
            userData.set(1800, forKey: "notiTime")
            
        }
        
        if userData.string(forKey: "already") == nil {
            userData.set("false" , forKey: "already")
        }
        
    
        
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appTerminated), name: UIApplication.didFinishLaunchingNotification, object: nil)
        
        introView.dataSource = self
        introView.delegate = self
        
        // Setup for Get Started Button
        getStartedButton.isHidden = true
        getStartedButton.layer.cornerRadius = 20
        getStartedButton.layer.borderColor = CGColor(srgbRed: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        getStartedButton.layer.backgroundColor = CGColor(srgbRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        getStartedButton.layer.borderWidth = 3.0
    }

    @objc func appTerminated () {

    }
    @objc func appMovedToBackground() {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        do {
            try Auth.auth().signOut()
        } catch let err {
            print (err)
        }
        IntroScreenViewController.shuffledFacts.shuffle()
        let isIndexValid = IntroScreenViewController.shuffledFacts.indices.contains(0)
        
        if isIndexValid {
            self.notificationPublisher.sendNotification(title: "New Fact!", subtitle: "", body: IntroScreenViewController.shuffledFacts[0]!, badge: 1, delayInterval: 1800)
            
        } else {
            self.notificationPublisher.sendNotification(title: "New Fact!", subtitle: "", body: "Canadians say “sorry” so much that a law was passed in 2009 declaring that an apology can’t be used as evidence of admission to guilt.", badge: 1, delayInterval: 1800)
            
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
        let bgTwo =  #colorLiteral(red: 0.5647058824, green: 0.9333333333, blue: 0.5647058824, alpha: 1)
        let bgOne =   #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)
        let descFont = UIFont(name: "AvenirNext-Regular", size: 18)
        
        let logo = UIImage(named: "logo-transparent")
        let icon = UIImage(named: "activeIndex")
        let bell = UIImage(named: "notification")
        let share = UIImage (named: "share")
        
        return [OnboardingItemInfo (informationImage: logo!, title: "Welcome To Factilicious", description: "Factilicious is the ultimate Fun Facts App! \n You can discover over 1000 amazing facts with this app. Save the facts you most like \n and show your friends!", pageIcon: icon!, color: bgTwo, titleColor: #colorLiteral(red: 0.8552109772, green: 0.07433366693, blue: 0.1143855852, alpha: 0.8505993151), descriptionColor: UIColor.black, titleFont: titleFont!, descriptionFont: descFont!),
                
                OnboardingItemInfo (informationImage: bell!, title: "Get Notifications Regularly", description: "Get an amazing fact delivered to you regularly. Simply allow Notifications and experience the magic!", pageIcon: icon!, color: bgOne, titleColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), descriptionColor: UIColor.white, titleFont: titleFont!, descriptionFont: descFont!),
                
                OnboardingItemInfo (informationImage: share!, title: "Share Facts Easily", description: "Factilicious allows you to share any fact you like with your family and friends, \n with a tap of a button.", pageIcon: icon!, color: bgThree, titleColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), descriptionColor: UIColor.black, titleFont: titleFont!, descriptionFont: descFont!),
            ] [index]
    }
    
    
}
