//
//  AppDelegate.swift
//  NSC
//
//  Created by Xu, Jay on 12/1/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import CoreLocation
import UserNotifications
import CoreBluetooth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    var ambassadors = [Ambassador]()
    var hapticDevice = false
    private var deviceType = 0 {
        didSet {
            if deviceType == 2 {
                hapticDevice = true
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Local notification
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .alert, .sound]) { (success, error) in
                if error != nil {
                    AlertCenter.throwAnAlert(title: "Error",
                                             message: error!.localizedDescription,
                                             completion: nil)
                }
            }
            application.registerForRemoteNotifications()
        } else {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound],
                                                                                             categories: nil))
        }
        
        //MARK: 3D Touch
        if let shortcutItems = application.shortcutItems , shortcutItems.isEmpty {
            // Construct the items.
            let shortcut1 = UIMutableApplicationShortcutItem(type: Shortcut.One.type,
                                                             localizedTitle: "Power Up Description",
                                                             localizedSubtitle: "Description about skills you gained.",
                                                             icon: UIApplicationShortcutIcon(type: .message), userInfo: [
                
                AppDelegate.applicationShortcutUserInfoIconKey: UIApplicationShortcutIconType.play.rawValue
                ]
            )
            
            let shortcut2 = UIMutableApplicationShortcutItem(type: Shortcut.Two.type,
                                                             localizedTitle: "Play", localizedSubtitle: "",
                                                             icon: UIApplicationShortcutIcon(type: .play),
                                                             userInfo: [
                AppDelegate.applicationShortcutUserInfoIconKey: UIApplicationShortcutIconType.pause.rawValue
                ]
            )
            
            // Update the application providing the initial 'dynamic' shortcut items.
            application.shortcutItems = [shortcut1, shortcut2]
        }
        
        IQKeyboardManager.shared().isEnabled = true
        LocationManger.defaultManager.requestAuthorization()
        
        //Check if device support haptic engine API
        if #available(iOS 10.0, *) {
            deviceType = UIDevice.current.value(forKey: "_feedbackSupportLevel") as! Int
        }
        defaultAmbassadors()

        guard !AmbassadorCollector.defaultCollector.restoreFromDisc() else {
            
            guard AmbassadorCollector.defaultCollector.collectedAmbassadors.count > 0 else {
                return true
            }
            for item in ambassadors {
                for am in AmbassadorCollector.defaultCollector.collectedAmbassadors {
                    if item.name == am.name {
                        item.showed = true
                        item.collected = true
                    }
                }
            }
            
            guard !AmbassadorCollector.defaultCollector.gameOver else {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let resultVC = sb.instantiateViewController(withIdentifier: "Result_VC")
                if resultVC.navigationController == nil {
                    window?.rootViewController = UINavigationController(rootViewController: resultVC)
                }else {
                    window?.rootViewController = resultVC.navigationController!
                }
                return true
            }
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let home = sb.instantiateViewController(withIdentifier: "LogIn")
            if window?.rootViewController is UINavigationController {
                (window?.rootViewController as! UINavigationController).pushViewController(home, animated: true)
            }else {
                window?.rootViewController = UINavigationController(rootViewController: home)
            }
            return true
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Deallocate"), object: nil)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if AmbassadorCollector.defaultCollector.gameOver == false {
            LocationManger.defaultManager.monitorBeacon()
        }else {
            LocationManger.defaultManager.stopMonitoring()
        }
        AmbassadorCollector.defaultCollector.saveToDisc()
        scheduleLocalNotification()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        LocationManger.defaultManager.stopMonitoring()
        for item in ambassadors {
            item.showed = false
            item.collected = false
        }
        if AmbassadorCollector.defaultCollector.collectedAmbassadors.count > 0 {
            for item in AmbassadorCollector.defaultCollector.collectedAmbassadors {
                for index in 0..<ambassadors.count {
                    if item.tag == ambassadors[index].tag {
                        ambassadors[index].showed = true
                        ambassadors[index].collected = true
                    }
                }
            }
        }
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.removePendingNotificationRequests(withIdentifiers: ["Logout","Skill"])
            center.removeDeliveredNotifications(withIdentifiers: ["Logout","Skill"])
            center.removeAllDeliveredNotifications()
            center.removeAllPendingNotificationRequests()
        }else {
            UIApplication.shared.cancelAllLocalNotifications()
        }
    }

    func applicationWillTerminate(_ application: UIApplication) {
        if AmbassadorCollector.defaultCollector.gameOver == false {
            LocationManger.defaultManager.monitorBeacon()
        }else {
            LocationManger.defaultManager.stopMonitoring()
        }
        AmbassadorCollector.defaultCollector.saveToDisc()
        scheduleLocalNotification()
    }
    
    //MARK: UNUserNotificationCenterDelegate
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
        let alert = UIAlertController(title: notification.request.content.title, message: notification.request.content.body, preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func scheduleLocalNotification () {
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = "App is about to log out"
            content.body = "We have stored your collected skills, you can continue playing the game when you launch app again."
            content.sound = UNNotificationSound.default()
            content.launchImageName = "AppIcon"
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 120, repeats: false)
            let request = UNNotificationRequest.init(identifier: "Logout", content: content, trigger: trigger)
            
            // Schedule the notification.
            let center = UNUserNotificationCenter.current()
            center.add(request) { (error) in
                if error != nil {
                    print(error!)
                }
            }
        } else {
            let notification = UILocalNotification()
            notification.fireDate = NSDate(timeIntervalSinceNow: 120) as Date
            notification.alertTitle = "App is about to log out"
            notification.alertBody = "We have stored your collected skills, you can continue playing the game when you launch app again."
            notification.alertLaunchImage = "AppIcon"
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(notification)
        }
    }
}

extension AppDelegate {
    static let applicationShortcutUserInfoIconKey = "applicationShortcutUserInfoIconKey"
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        let handledShortCutItem = handleQuickAction(shortcutItem: shortcutItem)
        completionHandler(handledShortCutItem)
    }
    
    enum Shortcut: String {
        case One
        case Two
        
        init?(fullType: String) {
            guard let last = fullType.components(separatedBy: ".").last else { return nil }
            
            self.init(rawValue: last)
        }
        
        var type: String {
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    func handleQuickAction(shortcutItem: UIApplicationShortcutItem) -> Bool {
        
        var quickActionHandled = false
        let type = shortcutItem.type
        
        switch type {
        case Shortcut.One.type:
            defaultAmbassadors()
            guard AmbassadorCollector.defaultCollector.restoreFromDisc() else {return false}
            guard AmbassadorCollector.defaultCollector.collectedAmbassadors.count > 0 else {return true}
            for item in ambassadors {
                for am in AmbassadorCollector.defaultCollector.collectedAmbassadors {
                    if item.name == am.name {
                        item.showed = true
                        item.collected = true
                    }
                }
            }
            guard AmbassadorCollector.defaultCollector.collectedAmbassadors.count>0 else {return false}
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let home = sb.instantiateViewController(withIdentifier: "SkillInfo_VC") as! SkillInfoViewController
            home.quickLauch = true
            if window?.rootViewController is UINavigationController {
                (window?.rootViewController as! UINavigationController).pushViewController(home, animated: true)
            }else {
                window?.rootViewController = UINavigationController(rootViewController: home)
            }
            return true
            
        case Shortcut.Two.type:
            defaultAmbassadors()
            guard !AmbassadorCollector.defaultCollector.restoreFromDisc() else {
                
                guard AmbassadorCollector.defaultCollector.collectedAmbassadors.count > 0 else {return true}
                for item in ambassadors {
                    for am in AmbassadorCollector.defaultCollector.collectedAmbassadors {
                        if item.name == am.name {
                            item.showed = true
                            item.collected = true
                        }
                    }
                }
                
                guard !AmbassadorCollector.defaultCollector.gameOver else {
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    let resultVC = sb.instantiateViewController(withIdentifier: "Result_VC")
                    if resultVC.navigationController == nil {
                        window?.rootViewController = UINavigationController(rootViewController: resultVC)
                    }else {
                        window?.rootViewController = resultVC.navigationController!
                    }
                    return true
                }
                
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let home = sb.instantiateViewController(withIdentifier: "Home")
                if window?.rootViewController is UINavigationController {
                    (window?.rootViewController as! UINavigationController).pushViewController(home, animated: true)
                }else {
                    window?.rootViewController = UINavigationController(rootViewController: home)
                }
                return true
            }
            quickActionHandled = true
            
        default:
            break
        }
        
        return quickActionHandled
    }
    
    func defaultAmbassadors() {
        ambassadors.removeAll()
        var count = 0
        let targetIDAmbassador = ["19bdde":"fly",
                                  "19bafd":"Exit",
                                  "19bddd":"Kungfu",
                                  "19ccc2":"Sunglasses",
                                  "19ba95":"Pill",
                                  "19cc42":"Rabbit",
                                  "19baa6":"Spoon",
                                  "19bcbb":"bluePill",
                                  "19bc97":"bullets"]
        for id in targetIDAmbassador.keys {
            let am = Ambassador()
            am.name = targetIDAmbassador[id]
            am.tag = id
            am.id = count
            am.showed = false
            am.collected = false
            count += 1
            ambassadors.append(am)
            print(am.name,count-1)
        }
    }
}

