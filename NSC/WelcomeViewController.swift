//
//  WelcomeViewController.swift
//  NSC
//
//  Created by Xu, Jay on 12/23/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var backGround: UIImageView!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var pinkBack: UIImageView!
    
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
        //Dynamic constrain for 5.5 inches iPhones
        //Magic numbers are resultion of image asset
        height.constant = (UIScreen.main.bounds.width - 40)*5558/3125
        top.constant = UIScreen.main.bounds.width - 60
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        shouldHideStatusBar = true
        UIView.animate(withDuration: 1, delay: 0.5, options: .curveEaseIn, animations: {
            self.backGround.alpha = 1
            self.registerBtn.alpha = 1
            self.loginBtn.alpha = 1
        }, completion: { (success) in
            self.backGround.shake()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
