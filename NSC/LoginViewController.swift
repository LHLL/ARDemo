//
//  LoginViewController.swift
//  NSC
//
//  Created by Xu, Jay on 12/1/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, AuthencationDelegate, UITextFieldDelegate,PhysicalFeedbackDelegate {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    private var shouldHideStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    private var name = false
    private var emailAdd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AccessGuard.defaultGuard.start()
        configureUIElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        shouldHideStatusBar = true
        autoFill()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action Trigger
    @IBAction func GoBack(_ sender: UIButton) {
        navigationController!.popToRootViewController(animated: true)
    }
    
    @IBAction func touchID(_ sender: UIButton) {
        if userName.isFirstResponder {
            userName.resignFirstResponder()
        }
        if email.isFirstResponder {
            email.resignFirstResponder() 
        }
        guard name else {
            feedBack(.error)
            userName.shake()
            AlertCenter.throwAnAlert(title: "Error", message: "User Name is not Right", completion: nil)
            return
        }
        guard emailAdd else {
            feedBack(.error)
            email.shake()
            AlertCenter.throwAnAlert(title: "Error", message: "User Email is not Right", completion: nil)
            return
        }
        let authenticateView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Touch_ID") as! TouchIDViewController
        authenticateView.view.layer.zPosition = 3
        authenticateView.delegate = self
        shouldHideStatusBar = true
        navigationController?.navigationBar.isHidden = true
        view.addSubview(authenticateView.view)
        view.bringSubview(toFront: authenticateView.view)
    }
    
    private func logIn() {
        navigationController?.navigationBar.isHidden = false
        let destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home")
        navigationController!.pushViewController(destination, animated: true)
    }
    
    //MARK:Utility Method
    private func configureUIElements() {
        shouldHideStatusBar = true
        let paddingForFirst = UIView(frame: CGRect(x:0, y:0, width:15, height:userName.frame.size.height))
        userName.leftView = paddingForFirst
        userName.leftViewMode = .always
        let paddingForSecond = UIView(frame: CGRect(x:0, y:0, width:15, height:email.frame.size.height))
        email.leftView = paddingForSecond
        email.leftViewMode = .always
        navigationController?.navigationBar.isHidden = true
    }
    
    private func autoFill() {
        guard AmbassadorCollector.defaultCollector.userName != nil && AmbassadorCollector.defaultCollector.userEmail != nil else {
            return
        }
        userName.text = AmbassadorCollector.defaultCollector.userName!
        email.text = AmbassadorCollector.defaultCollector.userEmail!
        emailAdd = true
        name = true
    }
    
    //MARK: AuthencationDelegate
    func authenticationSucceed(){
        shouldHideStatusBar = false
        logIn()
    }
    
    func authenticationFailed(){
        shouldHideStatusBar = false
        navigationController?.navigationBar.isHidden = false
    }
    
    //MARK: UITextFieldDelegate
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == userName {
            if textField.text!.trimmingCharacters(in: .whitespaces) == AmbassadorCollector.defaultCollector.userName {
                name = true
            }else {
                name = false
            }
        }else {
            if textField.text!.trimmingCharacters(in: .whitespaces) == AmbassadorCollector.defaultCollector.userEmail {
                emailAdd = true
            }else {
                emailAdd = false
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == userName {
            email.becomeFirstResponder()
        }
        return true
    }
}

protocol Shakeable {}

extension Shakeable where Self:UIView {
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x:self.center.x - 4.0, y:self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x:self.center.x + 4.0, y:self.center.y))
        layer.add(animation, forKey: "position")
    }
    
    func verticalShake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.5
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x:self.center.x, y:self.center.y - 15.0))
        animation.toValue = NSValue(cgPoint: CGPoint(x:self.center.x, y:self.center.y + 15.0))
        layer.add(animation, forKey: "position")
    }
}
