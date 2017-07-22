//
//  RegisterViewController.swift
//  NSC
//
//  Created by Xu, Jay on 12/22/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, PhysicalFeedbackDelegate {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var pinkMask: UIImageView!
    @IBOutlet weak var whiteBack: UIView!
    private var name:String?
    private var email:String?
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    private var shouldHideStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideStatusBar = true
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(toLoginVC),
                                               name: NSNotification.Name(rawValue: "RegisterSucceed"),
                                               object: nil)
        
        //Insert inset to fit background View
        let paddingForFirst = UIView(frame: CGRect(x:0, y:0, width:15, height:userName.frame.size.height))
        userName.leftView = paddingForFirst
        userName.leftViewMode = .always
        let paddingForSecond = UIView(frame: CGRect(x:0, y:0, width:15, height:password.frame.size.height))
        password.leftView = paddingForSecond
        password.leftViewMode = .always
        
        //Dynamic constrain for 5.5 inches iPhones
        height.constant = (UIScreen.main.bounds.width - 40)*5558/3125
        NotificationCenter.default.addObserver(self, selector: #selector(errorHandler(sender:)), name: NSNotification.Name(rawValue: "RegisterFailed"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        whiteBack.isHidden = true
        pinkMask.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toLoginVC() {
        performSegue(withIdentifier: "LoginVC", sender: nil)
    }
    
    //MARK: Action Trigger
    @IBAction func back(_ sender: UIButton) {
        navigationController!.popToRootViewController(animated: true)
    }
    
    @IBAction func register(_ sender: UIButton) {
        if password.isFirstResponder{
            password.resignFirstResponder()
        }
        
        guard selfCheck() else {
            return
        }
        //Make sure password has already resigned first responder
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) { 
            if self.name != nil && self.email != nil {
                self.whiteBack.isHidden = false
                self.pinkMask.isHidden = false
                self.pinkMask.loadGif(name: "loading")
                AmbassadorCollector.defaultCollector.registerUser(withName: self.name!, email: self.email!)
            }else {
                AlertCenter.throwAnAlert(title: "Error",
                                         message: "User Name and Email are both mandatory!",
                                         completion: nil)
            }
        }
    }
    
    func errorHandler(sender:Notification) {
        whiteBack.isHidden = true
        pinkMask.isHidden = true
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == userName {
            name = textField.text!.trimmingCharacters(in: .whitespaces)
        }else {
            email = textField.text!.trimmingCharacters(in: .whitespaces)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == userName {
            password.becomeFirstResponder()
        }
        return true
    }
    
    private func selfCheck()->Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailTest.evaluate(with: email!) {
            feedBack(.error)
            password.shake()
            password.text = ""
            DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
                AlertCenter.throwAnAlert(title: "Error", message: "Verify your email address", completion: nil)
            })
            return false
        }
        return true
    }
}

extension UIView:Shakeable {}
