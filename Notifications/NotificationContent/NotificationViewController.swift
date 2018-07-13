//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by Alexey Efimov on 12.07.2018.
//  Copyright © 2018 Alexey Efimov. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var label: UILabel?
    @IBOutlet weak var likeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func likeButtonTapped(_ sender: Any) {
        likeButton.setTitle("♥", for: .normal)
    }
    
    @IBAction func openAppButton(_ sender: Any) {
        openApp()
    }
    
    
    func openApp() {
        extensionContext?.performNotificationDefaultAction()
    }
    
    func dismissNotification() {
        extensionContext?.dismissNotificationContentExtension()
    }
    
    func didReceive(_ notification: UNNotification) {
        label?.text = notification.request.content.body
    }
    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        switch response.actionIdentifier {
        case "Snooze":
            let actions = [
                UNNotificationAction(identifier: "5 second",  title: "Отложить на 5 секунд", options: []),
                UNNotificationAction(identifier: "10 second",  title: "Отложить на 10 секунд", options: []),
                UNNotificationAction(identifier: "60 second",  title: "Отложить на 60 секунд", options: []),
                ]
            extensionContext?.notificationActions = actions
        case "Delete":
            dismissNotification()
        default:
            dismissNotification()
        }
    }
}
