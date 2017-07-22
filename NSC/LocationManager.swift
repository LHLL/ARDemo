//
//  LocationManager.swift
//  NSC
//
//  Created by Xu, Jay on 12/1/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation
import CoreLocation
import CoreBluetooth
import UserNotifications

class LocationManger:NSObject, CLLocationManagerDelegate, MPactClientDelegate {
    
    static var defaultManager = LocationManger()
    private var locationManager: CLLocationManager!
    private lazy var mpactClient:MPactClient = {
        return MPactClient.initClient()
    }() as! MPactClient
    weak var delegate:LocationManagerDelegate?
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let range:CLBeaconRegion = CLBeaconRegion(proximityUUID: UUID(uuidString: "FE913213-B311-4A42-8C16-47FAEAC938DB")!,
                                                      identifier: "Matrix")
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 10
        
        mpactClient.clientName = "NSC"
        mpactClient.beaconType = .typeMPact
        mpactClient.iBeaconUUID = UUID(uuidString: "FE913213-B311-4A42-8C16-47FAEAC938DB")
    }
    
    func start() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        mpactClient.delegate = self
        mpactClient.start()
        checkBackgroundRefresh()
    }
    
    func stop() {
        mpactClient.stop()
        locationManager.stopUpdatingHeading()
        locationManager.stopUpdatingLocation()
    }
    
    func monitorBeacon() {
        range.notifyOnEntry = true
        //locationManager.startMonitoring(for: range)
        locationManager.delegate = self
        locationManager.startRangingBeacons(in: range)
    }
    
    func stopMonitoring() {
        //locationManager.stopMonitoring(for: range)
        locationManager.stopRangingBeacons(in: range)
    }
    
    func requestAuthorization() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = "Skill Detected"
            content.body = "Launch the App to find skill"
            content.sound = UNNotificationSound.default()
            content.launchImageName = "AppIcon"
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest.init(identifier: "Skill", content: content, trigger: trigger)
            
            // Schedule the notification.
            let center = UNUserNotificationCenter.current()
            center.add(request) { (error) in
                if error != nil {
                    print(error!)
                }
            }
        } else {
            let notification = UILocalNotification()
            notification.fireDate = NSDate(timeIntervalSinceNow: 1) as Date
            notification.alertTitle = "Skill Detected"
            notification.alertBody = "Launch the App to find skill"
            notification.alertLaunchImage = "AppIcon"
            notification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(notification)
        }
    }
    
    //MARK: MPactClientDelegate
    func mPactClient(_ client: Any!, closestTag tag: MPactTag!) {
        print("detect:\(tag.tagID!)")
        for ambassador in appDelegate.ambassadors {
            if ambassador.tag == tag.tagID {
                if !ambassador.collected {
                    print("pass:\(tag.tagID!)")
                    if !ambassador.showed {
                        guard !(AmbassadorCollector.defaultCollector.collectedAmbassadors.contains(ambassador)) else {
                            ambassador.showed = true
                            ambassador.collected = true
                            return
                        }
                        delegate?.showRabbit(ambassador)
                        return
                    }
                }
            }
        }
    }
    
    func mPactClient(_ client: Any!, didDetermineState state: CLRegionState) {
        switch state {
        case .inside:
            print("inside")
        case .outside:
            print("outside")
            delegate?.hideRabbit()
            
        default:
            break
        }
    }
}

protocol LocationManagerDelegate:class {
    func showRabbit(_ ambassador:Ambassador)
    func hideRabbit()
}

extension LocationManger {
    func checkBackgroundRefresh() {
        if UIApplication.shared.backgroundRefreshStatus != .available {
            AlertCenter.throwAnAlert(title: "Background Refresh is not Available",
                                     message: "Please go to 'setting->general->Background App Refresh' to enable background app refresh function",
                                     completion: nil)
        }else {
            print("approved")
        }
    }
}
