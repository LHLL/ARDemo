//
//  TouchIDViewController.swift
//  NSC
//
//  Created by Xu, Jay on 12/1/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDViewController: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet private weak var mUpperView: UIView!
    @IBOutlet private weak var mVerifingLabel: UILabel!
    @IBOutlet private weak var mActivityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var mArrowTop: UIImageView!
    @IBOutlet private weak var mArrowMiddle: UIImageView!
    @IBOutlet private weak var mArrowBot: UIImageView!
    
    private var shouldStart = false
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    private var shouldHideStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    weak var delegate:AuthencationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        shouldHideStatusBar = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startAnimation()
        shouldHideStatusBar = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: UI related
    func configureUIElements(){
        mUpperView.layer.cornerRadius = 5
        mUpperView.layer.masksToBounds = true
        mArrowTop.image = IonIcons.image(withIcon: ion_arrow_down_b,
                                         iconColor: UIColor.white,
                                         iconSize: 20,
                                         imageSize: CGSize(width: 20, height: 20))
        mArrowMiddle.image = IonIcons.image(withIcon: ion_arrow_down_b,
                                            iconColor: UIColor.white,
                                            iconSize: 20,
                                            imageSize: CGSize(width: 20, height: 20))
        mArrowBot.image = IonIcons.image(withIcon: ion_arrow_down_b,
                                         iconColor: UIColor.white,
                                         iconSize: 20,
                                         imageSize: CGSize(width: 20, height: 20))
        mArrowMiddle.alpha = 0
        mArrowBot.alpha = 0
        mArrowTop.alpha = 0
        runActivityIndicator(flag: false)
    }
    
    func runActivityIndicator(flag:Bool){
        if flag {
            mVerifingLabel.isHidden = false
            mActivityIndicator.isHidden = false
            mActivityIndicator.startAnimating()
        }else {
            mActivityIndicator.isHidden = true
            mActivityIndicator.stopAnimating()
        }
    }
    
    func startAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.mArrowTop.alpha = 1
        }) { (success) in
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                self.mArrowMiddle.alpha = 1
            }) { (success) in
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
                    self.mArrowBot.alpha = 1
                }) { (success) in
                    self.shouldStart = true
                    self.mArrowMiddle.alpha = 0
                    self.mArrowBot.alpha = 0
                    self.mArrowTop.alpha = 0
                    self.startAnimation()
                }
            }
        }
        guard !shouldStart else {return}
        startAuthenticate()
    }
    
    //MARK: Touch ID Authentication
    func startAuthenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Authenticate User"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {
                    [unowned self] (success, authenticationError) in
                    DispatchQueue.main.async {
                        self.view.removeFromSuperview()
                        if success {
                            self.delegate?.authenticationSucceed()
                            print("threre")
                        } else {
                            print("here")
                            self.delegate?.authenticationFailed()
                            AlertCenter.throwAnAlert(title: "Error",
                                                     message: "Authentication Failed.",
                                                     completion: nil)
                        }
                    }
                }
                
            }
        } else {
            DispatchQueue.main.async {
                self.view.removeFromSuperview()
                self.delegate?.authenticationFailed()
            }
            AlertCenter.throwAnAlert(title: "Error",
                                     message: "Your device does not have Touch ID or enrolled fingerprint.",
                                     completion: nil)
        }
    }
}

protocol AuthencationDelegate: class {
    func authenticationSucceed()
    func authenticationFailed()
}
