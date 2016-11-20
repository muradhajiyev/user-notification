//
//  NotificationViewController.swift
//  MyContentExtension
//
//  Created by Murad Hajiyev on 11/20/16.
//  Copyright © 2016 Murad Hajiyev. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        guard let attachment = notification.request.content.attachments.first else{
            return 
        }
        
        if attachment.url.startAccessingSecurityScopedResource() {
            let imageData = try? Data.init(contentsOf: attachment.url)
            if let img = imageData{
                imageView.image = UIImage(data: img)
            }
        }
    }

}
