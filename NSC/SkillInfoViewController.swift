//
//  SkillInfoViewController.swift
//  NSC
//
//  Created by Xu, Jay on 1/4/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit

class SkillInfoViewController: UIViewController {


    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var sweetBtn: UIButton!
    @IBOutlet weak var arrowView: UIImageView!
    @IBOutlet weak var swipw: UISwipeGestureRecognizer!
    
    var index = 0
    var quickLauch = false
    
    private let constantStr = "You got a power up. Power ups make you stronger.\n\nThink about how you can power up your business.\n\n"
    private lazy var skillDetails:[[String:String]] = {
        return [["Value Added APIs":"Customers' mobile app a little blah? Value Added APIs can help enhance their mobile app experience."],
                 ["Merchant Services":"Got card? The most ubiquitous form of payment can only happen with Merchant Services."],
                 ["E-Bill Express":"Checks are old school. Our customers can offer online, mobile or IVR payments channels with E-Bill Express. E-Bill Express hosts the web pages, saving IT development time and costs."],
                 ["Jay Payment Gateway":"Going OmniChannel? Jay Payment Gateway lets your customers control the front end while doing the heavy lifting on the backend. And it fights fraud too!"],
                 ["Print Services":"Customers tired of printing bills and stuffing envelopes? Outsource to Print Services and never lick another stamp!"],
                 ["E-Box®":"Getting payments but don't know from who to where? Let E-Box® help solve who, what and where for you."],
                 ["Lock Box":"Mail thief got your payments? Lockbox securely receives and processes your card or check payments without giving you a single paper cut."],
                 ["Clover":"Like things simple? The Clover family of Point of Sale Systems are easy to use and they look cool too!"],
                 ["Push to Card":"Customers want to push real time payments to their consumers 24/7/365? Push To Card will provide real time payments by pushing a credit to a consumer’s debit card."]
                 ]
    }()
    
    private var minHeight:CGFloat {
        get {
            //Yes, we only support 4.7 inches and 5.5 inches iPhones,get new phones if your devices are older than iPhone 6
            if UIScreen.main.scale > 2.9 {
                return 320
            }else {
                return 250
            }
        }
    }
    private var defaultFrame:CGRect!
    private var count = 0
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    private var shouldHideStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    weak var delegate:SkillDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElement()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.isHidden = true
        shouldHideStatusBar = true
        contentTextView.frame = CGRect(origin: contentTextView.frame.origin,
                                       size: CGSize(width: contentTextView.frame.width,
                                                    height: 0))
        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseIn, animations: { 
            self.contentTextView.frame = CGRect(origin: self.defaultFrame.origin,
                                                size: CGSize(width: self.defaultFrame.width,
                                                             height: self.defaultFrame.height))
        }) { (success) in
            self.sweetBtn.isEnabled = true
        }
        arrowView.loadGif(name: "top")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Action Trigger
    @IBAction func next(_ sender: UISwipeGestureRecognizer) {
        startAnimation()
    }
    
    @IBAction func showNext(_ sender: UITapGestureRecognizer) {
        startAnimation()
    }

    @IBAction func back(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
        delegate?.shouldRestartGame()
    }
    
    //MARK:Animation
    func startAnimation() {
        guard count < AmbassadorCollector.defaultCollector.collectedAmbassadors.count-1 else {
            swipw.isEnabled = false
            arrowView.isUserInteractionEnabled = false
            arrowView.isHidden = true
            count = 0
            AlertCenter.throwAnAlert(title: "You haven't gained more skills",
                                     message: "Click sweet to collect more skills",
                                     completion: nil)
            return
        }
        sweetBtn.isEnabled = false
        swipw.isEnabled = false
        arrowView.isUserInteractionEnabled = false
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseIn, animations: {
            self.titleLabel.alpha = 0
            self.contentTextView.frame = CGRect(origin: self.defaultFrame.origin,
                                                size: CGSize(width: self.defaultFrame.width,
                                                             height: self.defaultFrame.height-self.minHeight))
            self.contentTextView.alpha = 0.3
            self.sweetBtn.alpha = 0
        }) { (success) in
            self.count += 1
            self.index = AmbassadorCollector.defaultCollector.collectedAmbassadors[self.count].id
            self.titleLabel.text = (self.skillDetails[self.index].keys.first)!
            self.contentTextView.text = self.constantStr + (self.skillDetails[self.index].values.first)!
            UIView.animate(withDuration: 2, delay: 0, options: .curveEaseIn, animations: {
                self.titleLabel.alpha = 1
                self.contentTextView.frame = CGRect(origin: self.defaultFrame.origin,
                                                    size: CGSize(width: self.defaultFrame.width,
                                                                 height: self.defaultFrame.height))
                self.contentTextView.alpha = 1
                self.sweetBtn.alpha = 1
            }) { (success) in
                self.sweetBtn.isEnabled = true
                self.swipw.isEnabled = true
                self.arrowView.isUserInteractionEnabled = true
            }
        }
    }
    
    func configureUIElement() {
        count = 0
        navigationController?.navigationBar.isHidden = true
        shouldHideStatusBar = true
        defaultFrame = contentTextView.frame
        sweetBtn.isEnabled = false
        if AmbassadorCollector.defaultCollector.collectedAmbassadors.count > 0 && quickLauch {
            index = AmbassadorCollector.defaultCollector.collectedAmbassadors.first!.id
        }
        if AmbassadorCollector.defaultCollector.collectedAmbassadors.count > 1 && quickLauch {
            arrowView.isHidden = false
            arrowView.isUserInteractionEnabled = true
        }
        titleLabel.text = (skillDetails[index].keys.first)!
        contentTextView.text = constantStr + (skillDetails[index].values.first)!
    }
}

protocol SkillDelegate:class {
    func shouldRestartGame()
}

extension UIView{
    func copyView() -> UIView!{
        return NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self))! as! UIView
    }
}

