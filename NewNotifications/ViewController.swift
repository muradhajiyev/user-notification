//
//  ViewController.swift
//  NewNotifications
//
//  Created by Murad Hajiyev on 11/20/16.
//  Copyright © 2016 Murad Hajiyev. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. REQUEST PERMISSION
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification access granted")
            }else{
                print(error?.localizedDescription as Any)
            }
        })
    }
    
    
    @IBAction func notifyButtonTapped(_ sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Successfully scheduled notification")
            }else{
                print("Error scheduling notification")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()){
        
        // Add an attachment
        let myImage = "giphy"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else{
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        
        let notif = UNMutableNotificationContent()
        
        //ONLY FOR EXTENSION
        notif.categoryIdentifier = "myNotificationCategory"
        
        notif.title = "New Notification"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in IOS 10 are what I've always dreamed of!"
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil{
                print(error!)
                completion(false)
            }else{
                completion(true)
            }
        })
        
    }
}

