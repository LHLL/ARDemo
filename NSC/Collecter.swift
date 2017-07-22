//
//  Collecter.swift
//  NSC
//
//  Created by Xu, Jay on 12/15/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation

class AmbassadorCollector {
    
    static var defaultCollector = AmbassadorCollector()
    
    var gameOver:Bool = false
    
    private let userDefaults = UserDefaults(suiteName: "group.com.wf.NSC")!
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var confirmationCode:String?
    
    var collectedAmbassadors:[Ambassador] {
        return ambassadors                 
    }
    private var ambassadors = [Ambassador]() {
        didSet {
            selfCheck()
            if ambassadors.count == 9 {
                registerWinner()
                LocationManger.defaultManager.stop()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Done"),
                                                object: nil,
                                                userInfo: nil)
            }else {
                gameOver = false
            }
        }
    }
    
    //User Info:
    var userName:String? {
        get {
            return name
        }
    }
    
    var userEmail:String? {
        get {
            return email
        }
    }
    
    private var name:String?
    private var email:String?
    
    //MARK:Utility Method:
    func collect(_ am:Ambassador){
        if !collectedAmbassadors.contains(am) {
            ambassadors.append(am)
        }
        am.collected = true
    }
    
    func registerUser(withName name:String, email:String) {
        
        WebServiceHandler.defaultManager().checkUiqueness(withUserName: email) { (new, error) in
            if !new {
                AlertCenter.throwAnAlert(title: "User Existed",
                                         message: "This email address has been used for an existing user",
                                         completion: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RegisterFailed"), object: nil)
            }else if error != nil {
                AlertCenter.throwAnAlert(title: "Error",
                                         message: error!,
                                         completion: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RegisterFailed"), object: nil)
            }else {
                self.name = name
                self.email = email
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "RegisterSucceed"), object: nil)
                
            }
        }
    }
    
    //MARK: API Call Handler
    private func registerWinner(){
       WebServiceHandler.defaultManager().startRegisteringUser(with: name, email) { (success, error) in
           if success {
            
           }else if error != nil {
              AlertCenter.throwAnAlert(title: "Error", message: error!, completion: nil)
           }
        }
    }
    
    //MARK: Persistence Storage
    func saveToDisc() {
        guard name != nil else {
            return
        }
        
        guard email != nil else {
            return
        }
        
        userDefaults.set(name!, forKey: "name")
        userDefaults.set(userEmail!, forKey: "email")
        userDefaults.set(gameOver, forKey: "gameOver")
        userDefaults.set(confirmationCode, forKey: "confirmaion")
        
        var archivedAmbassadors = [[Any]]()
        var names = [String]()
        var tags = [String]()
        var indexs = [Int]()
        for ambassador in collectedAmbassadors {
            names.append(ambassador.name)
            tags.append(ambassador.tag)
            indexs.append(ambassador.id)
        }
        archivedAmbassadors.append(names)
        archivedAmbassadors.append(tags)
        archivedAmbassadors.append(indexs)
        userDefaults.set(archivedAmbassadors, forKey: "ambassador")
        
    }
    
    func restoreFromDisc()->Bool{
        if userDefaults.value(forKey: "name") != nil {
            name = userDefaults.value(forKey: "name") as? String
            email = userDefaults.value(forKey: "email") as? String
            confirmationCode = userDefaults.value(forKey: "confirmation") as? String
            
            if userDefaults.value(forKey: "ambassador") != nil {
                let ams = userDefaults.value(forKey: "ambassador") as! [[Any]]
                ambassadors.removeAll()
                for index in 0..<ams[0].count {
                    let am = Ambassador()
                    am.showed = true
                    am.collected = true
                    am.name = ams[0][index] as! String
                    am.tag = ams[1][index] as! String
                    am.id = ams[2][index] as! Int
                    ambassadors.append(am)
                }
            }
            gameOver = userDefaults.value(forKey: "gameOver") as! Bool
            return true
        }else {
            return false
        }
    }
    
    func selfCheck() {
        for item in appDelegate.ambassadors {
            if collectedAmbassadors.contains(item) {
                item.collected = true
                item.showed = true
            }
        }
    }
    
    func clean(){
        ambassadors.removeAll()
        name = nil
        email = nil
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        for item in appDelegate.ambassadors {
            item.showed = false
            item.collected = false
        }
    }
}
