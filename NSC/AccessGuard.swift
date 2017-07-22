//
//  InternetGuard.swift
//  Wallet10
//
//  Created by Xu, Jay on 11/30/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation
import CoreBluetooth
import CoreLocation
import SystemConfiguration

class AccessGuard {
    
    static var defaultGuard = AccessGuard()
    
    private var internetGuard = InternetAccessGuard.defaultGuard
    private var bluttothGuard = BLEGuard.defaultGuard
    private var locationGuard = LocationServiceGuard.defaultGuard
    
    private var errors:[String] = [String]() {
        didSet{
            guard errors.count >= 3 else {return}
            for error in errors {
                if error == "Well Done" {
                    errors.remove(at: errors.index(of: error)!)
                }
            }
            guard errors.count != 0 else {return}
            guard errors.count > 1 else {
                AlertCenter.throwAnAlert(title: "Error", message: errors[0], completion: nil)
                return
            }
            AlertCenter.throwAlerts(titles: ["Error","Error","Error"], messages: errors, completions: nil)
        }
    }
    
    func start(){
        NotificationCenter.default.addObserver(self, selector: #selector(completionHandler),
                                               name: NSNotification.Name(rawValue: "InternetCheckDone"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(completionHandler),
                                               name: NSNotification.Name(rawValue: "BluetoothCheckDone"),
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(completionHandler),
                                               name: NSNotification.Name(rawValue: "LocationCheckDone"),
                                               object: nil)
        internetGuard.startCheckingInternet()
        bluttothGuard.startCheckingBLE()
        locationGuard.startCheckingLocationService()
    }
    
    @objc private func completionHandler(notification:NSNotification){
        if notification.name == NSNotification.Name(rawValue: "InternetCheckDone") {
            errors.append(notification.userInfo?["completion"] as! String)
        }else if notification.name == NSNotification.Name(rawValue: "BluetoothCheckDone") {
            NotificationCenter.default.removeObserver(self,
                                                      name: NSNotification.Name(rawValue: "BluetoothCheckDone"),
                                                      object: nil)
            errors.append(notification.userInfo?["completion"] as! String)
        }else if notification.name == NSNotification.Name(rawValue: "LocationCheckDone") {
            NotificationCenter.default.removeObserver(self,
                                                      name: NSNotification.Name(rawValue: "LocationCheckDone"),
                                                      object: nil)
            errors.append(notification.userInfo?["completion"] as! String)
        }
    }
}

class InternetAccessGuard {
    /*
     Note:
        1. Throw an error if device does not connect to WIFI or LTE.
        2. If WIFI, try to connect to "google.com" to make sure WIFI router has internet access.
     */
    static var defaultGuard = InternetAccessGuard()
    
    private var reachability:Reachability = Reachability.forInternetConnection()
    private let google = "https://www.google.com"
    private var googleReachability:Reachability!
    
    //This property is for AccessGuard to collect info
    private var completion:String! {
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "InternetCheckDone"),
                                            object: nil,
                                            userInfo: ["completion":completion])
        }
    }
    
    func startCheckingInternet(){
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            completion = "Oops, internet is not available. App needs internet."
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        if isReachable && !needsConnection {
            completion = "Well Done"
            startMonitoringInternetConnection()
        }else {
            completion = "Oops, internet is not available. App needs internet."
        }
    }
    
    private func startMonitoringInternetConnection() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(note:)),
                                               name: NSNotification.Name.reachabilityChanged,
                                               object: nil)
        reachability.startNotifier()
    }
    
    private func stopMonitoringinternetConnection() {
        reachability.stopNotifier()
    }
    
    @objc func reachabilityChanged(note:NSNotification){
        updateInterFaceWithReachability(note.object as! Reachability)
    }
    
    private func updateInterFaceWithReachability(_ reachability:Reachability) {
        let netWorkStatus = reachability.currentReachabilityStatus()
        guard reachability == self.reachability else {
            googleReachability.stopNotifier()
            if reachability.connectionRequired() {
               completion = "Oops, you need to manully connect to internet."
            }
            /*else {
               completion = "WoW, Interet, my precious!"
            }*/
            return
        }
        switch netWorkStatus {
        case NotReachable:
            completion = "Oops, internet is not available. App needs internet, yes, App needs it."
        case ReachableViaWiFi:
            googleReachability = Reachability(hostName:google)
            googleReachability.startNotifier()
            
        case ReachableViaWWAN:
            googleReachability = Reachability(hostName:google)
            googleReachability.startNotifier()
            
        default:
            break
        }
    }
}

class BLEGuard: NSObject, CBPeripheralManagerDelegate {
    
    static var defaultGuard = BLEGuard()
    private var peripheralManager:CBPeripheralManager?
    
    //This property is for AccessGuard to collect info
    private var completion:String! {
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "BluetoothCheckDone"),
                                            object: nil,
                                            userInfo: ["completion":completion])
        }
    }
    
    func startCheckingBLE(){
        let options = [CBCentralManagerOptionShowPowerAlertKey:0]
        peripheralManager = CBPeripheralManager(delegate: self,
                                                queue: nil,
                                                options: options)
    }
    
    //MARK: CBPeripheralManagerDelegate
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        switch peripheral.state {
            
        case .poweredOff:
            completion = "Your bluetooth is off, please turn it on. App needs access to bluetooth to work properly."
            
        case .resetting:
            completion = "Reset your bluetooth"
            
        case .unauthorized:
            completion = "Your bluetooth is unauthorized. App needs access to bluetooth to work properly."
            
        case .unsupported:
            completion = "Your device does not have bluetooth. App needs access to bluetooth to work properly."
            
        default:
            completion = "Well Done"
        }
    }
}

class LocationServiceGuard:NSObject {
    
    static var defaultGuard = LocationServiceGuard()
    
    //This property is for AccessGuard to collect info
    private var completion:String! {
        didSet{
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LocationCheckDone"),
                                            object: nil,
                                            userInfo: ["completion":completion])
        }
    }
    
    func startCheckingLocationService(){
        let status = CLLocationManager.locationServicesEnabled()
        if !status {
            completion = "Please enable location service for this App, App needs location service to work properly."
        }else {
            completion = "Well Done"
        }
    }
}
