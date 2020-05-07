//
//  Notification.swift
//  Factilicious
//
//  Created by Arnav Arora on 06/05/20.
//  Copyright © 2020 Jayant Arora. All rights reserved.
//

import UIKit
import Foundation
import UserNotifications

class NotificationPublisher: NSObject {
    
    static var already: Bool = false
    
    static let defaults = UserDefaults.standard
    
    
    func sendNotification (title: String,
                           subtitle: String,
                           body: String,
                           badge: Int?,
                           delayInterval: Int?) {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.subtitle = subtitle
        notificationContent.body = body
        
        var delayTimeTrigger: UNTimeIntervalNotificationTrigger?
        
        if let delayInterval = delayInterval {
            delayTimeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval (delayInterval), repeats: false)
        }
        
        if let badge = badge {
            var currentBadgeCount = UIApplication.shared.applicationIconBadgeNumber
            currentBadgeCount += badge
            notificationContent.badge = NSNumber(integerLiteral: currentBadgeCount)
        }
        
        notificationContent.sound = UNNotificationSound.default
        
        UNUserNotificationCenter.current().delegate = self
        
        let request = UNNotificationRequest(identifier: "factNotification", content: notificationContent, trigger: delayTimeTrigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print (error.localizedDescription)
            }
        }
    }
    
}

extension NotificationPublisher: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print ("Notification about to be presented!")
        
        completionHandler([.badge, .sound, .alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let identifier = response.actionIdentifier
        
        switch identifier {
            
        case UNNotificationDismissActionIdentifier:
            print ("Notification was dismissed.")
            completionHandler()
        case UNNotificationDefaultActionIdentifier:
            print ("User opened the app from Notification.")
            completionHandler()
            
        default:
            print ("The default case was called")
            completionHandler()
        
        }
        
        
    }
    
}
