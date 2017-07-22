//
//  AlertCenter.swift
//  NSC
//
//  Created by Xu, Jay on 12/1/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import Foundation

struct AlertCenter {
    
    static private let containerVC = UIApplication.shared.keyWindow?.rootViewController
    static private var errors = [String]()
    static private var titles = [String]()
    static private var completions = [(()->Void)]()
    static private var existingAlert:UIAlertController? {
        didSet {
            guard existingAlert == nil else {
                return
            }
            throwAlerts(titles: titles, messages: errors, completions: completions)
        }
    }
    
    static func throwAnAlert(title:String, message: String, completion:(()->Void)?) {
        guard containerVC?.presentedViewController == nil else {
            existingAlert = containerVC?.presentedViewController as? UIAlertController
            errors.append(message)
            titles.append(title)
            if completion != nil {
                completions.append(completion!)
            }
            return
        }
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            completion?()
            if self.existingAlert != nil {
                self.existingAlert = nil
            }
        })
        alertVC.addAction(action)
        DispatchQueue.main.async {
            containerVC?.present(alertVC, animated: true, completion: nil)
        }
    }
    
    static func throwAlerts(titles:[String], messages: [String], completions:[(()->Void)]?) {
        errors = messages
        self.titles = titles
        if completions != nil {
            self.completions = completions!
        }
        if let error = messages.first {
            let alertVC = UIAlertController(title: titles.first, message: error, preferredStyle: .alert)
            var next:UIAlertAction?
            guard messages.count != 1 else {
                next = UIAlertAction(title: "OK", style: .cancel, handler: {(action) in
                    if self.completions.count > 0 {
                        self.completions.last!()
                    }
                })
                alertVC.addAction(next!)
                containerVC?.present(alertVC, animated: true, completion: nil)
                return
            }
            next = UIAlertAction(title: "Next",
                                 style: .default,
                                 handler: { (action) in
                if self.completions.count > 0 {
                    let result = self.completions.removeFirst()
                    result()
                }
                self.errors.removeFirst()
                self.titles.removeFirst()
                                    
                DispatchQueue.main.async {
                    self.throwAlerts(titles: self.titles,
                                   messages: self.errors,
                                completions: self.completions)
            }
            })
            alertVC.addAction(next!)
            DispatchQueue.main.async {
                containerVC?.present(alertVC,
                                     animated: true,
                                     completion: nil)
            }
        }
    }
    
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
    //TODO: Education Methods, do not call any methods below! Again, this is not a drill, do not call any methods below unless you get permission from Andrew.L.Martinez.
    /*
    static private var botView:UIView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
    static private var topView:UIView = UIView(frame: CGRect(x: 0, y: -UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
    static func showAnAlert(alertMessage:String) {
        let alertVC = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Yes Sir", style: .cancel, handler: nil)
        let reject = UIAlertAction(title: "NO NO NO", style: .default) { (reject) in
            playTrailer()
        }
        alertVC.addAction(action)
        alertVC.addAction(reject)
        containerVC?.present(alertVC, animated: true, completion: nil)
    }
    
    static func playTrailer() {
        
        topView.backgroundColor = UIColor.black
        botView.backgroundColor = UIColor.black
        containerVC?.view.addSubview(topView)
        containerVC?.view.addSubview(botView)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.topView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
            self.botView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        }) { (success) in
            let label = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/2-11, width: UIScreen.main.bounds.width, height: 21))
            label.text = "GG noob, behave smarter next time!"
            label.textColor = UIColor.white
            containerVC?.view.addSubview(label)
            UIView.animate(withDuration: 3, delay: 0, options: .curveEaseIn, animations: {
                label.frame = CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height/2-11, width: UIScreen.main.bounds.width, height: 21)
            }) { (success) in
                let arr = [String]()
                print(arr[1])
            }
        }
    }*/
    
}
