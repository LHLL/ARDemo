//
//  HomeViewController.swift
//  NSC
//
//  Created by Xu, Jay on 12/1/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class HomeViewController: UIViewController, LocationManagerDelegate, PRARManagerDelegate, PhysicalFeedbackDelegate {
    
    @IBOutlet weak var pinkOverLay: UIImageView!
    @IBOutlet var skills: [UIImageView]!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gameTrigger: UITapGestureRecognizer!
    
    private var ob:ARObject?
    private var fight = false
    private var started = false
    private var radarV:UIView?
    private var arV:UIView?
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    private var shouldHideStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    private var ambassador:Ambassador?
    private var arManager:PRARManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideStatusBar = true
        navigationController?.navigationBar.isHidden = true
        LocationManger.defaultManager.start()
        
        height.constant = (UIScreen.main.bounds.width-64)/8*2
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(fightAgent(sender:)),
                                               name: NSNotification.Name(rawValue: "Done"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(deallocateAR(sender:)),
                                               name: NSNotification.Name(rawValue: "Deallocate"),
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        shouldHideStatusBar = true
        restoreStoredSkill()
        navigationController?.navigationBar.isHidden = true
        arManager = PRARManager(size: view.frame.size, delegate: self, showRadar: true)
    }
    
    //MARK: Action Trigger
    @IBAction func showSkillInfo(_ sender: UITapGestureRecognizer) {
        guard skills[sender.view!.tag].image != UIImage(named: "blank") else {
            AlertCenter.throwAnAlert(title: "You haven't gained this skill", message: "Gain the skill then check out details.", completion: nil)
            return
        }
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let destination = sb.instantiateViewController(withIdentifier: "SkillInfo_VC") as! SkillInfoViewController
        destination.delegate = self
        destination.index = tagFinder(tag: sender.view!.tag)
        destination.quickLauch = false
        self.navigationController!.pushViewController(destination, animated: true)
        deallocateAR(sender: nil)
    }
    
    @IBAction func startGame(_ sender: UITapGestureRecognizer) {
        if arManager == nil {
            arManager = PRARManager(size: view.frame.size, delegate: self, showRadar: true)
        }
        configureAR()
        if AmbassadorCollector.defaultCollector.gameOver == true {
            fightAgent(sender: nil)
        }
        LocationManger.defaultManager.delegate = self
        sender.isEnabled = false
    }
    
    //MARK: Utility
    func configureAR() {
        let location = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        arManager?.startAR(withData: [createPoint(at: getRandomLocation())], forLocation: location)
        let num = 0 as NSNumber
        ob = arManager?.arController.geoobjectOverlays[num] as! ARObject?
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapHandler(sender:)))
        self.ob?.rabbit.addGestureRecognizer(tap)
        view.bringSubview(toFront: containerView)
        containerView.isHidden = false
        if started {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                if self.ambassador!.name == "Rabbit" {
                    self.ob?.rabbit.loadGif(name: "rabbit")
                }else if self.ambassador!.name == "fly" {
                    self.ob?.rabbit.loadGif(name: "fly")
                }else if self.ambassador!.name == "Exit" {
                    self.ob?.rabbit.loadGif(name: "exit")
                }else if self.ambassador!.name == "Pill" {
                    self.ob?.rabbit.loadGif(name: "pill")
                }else if self.ambassador!.name == "Kungfu" {
                    self.ob?.rabbit.loadGif(name: "kungfu")
                }else if self.ambassador!.name == "Sunglasses" {
                    self.ob?.rabbit.loadGif(name: "sunglasses")
                }else if self.ambassador!.name == "Spoon" {
                    self.ob?.rabbit.loadGif(name: "spoon")
                }else if self.ambassador!.name == "bluePill" {
                    self.ob?.rabbit.loadGif(name: "bluePill")
                }else if self.ambassador!.name == "bullets" {
                    self.ob?.rabbit.loadGif(name: "bullets")
                }
                self.arManager?.showRadarSpots()
                self.view.bringSubview(toFront: (self.ob?.rabbit)!)
                AlertCenter.throwAnAlert(title: "Watch Out!",
                                         message: "Following the dot on the radar to find floating skill icon",
                                         completion: nil)
                self.ob?.rabbit.isHidden = false
                self.feedBack(.beacon)
            })
        }else {
            started = true
            self.ob?.rabbit.isHidden = true
        }
    }
    
    func getRandomLocation()->CLLocationCoordinate2D {
        let lat:Double =  90
        let lon:Double = 180

        return CLLocationCoordinate2D(latitude: lat, longitude: 2*lon)
    }
    
    func createPoint(at coordinate:CLLocationCoordinate2D)->[String:Any]{
        return ["id":0,
                "title":"fdfd",
                "lon":coordinate.longitude,
                "lat":coordinate.latitude]
    }
    
    private func showGainSkill () {
        if self.ambassador!.name == "Rabbit" {
            skills[1].image = UIImage(named: "rabbit")
        }else if self.ambassador!.name == "fly" {
            skills[8].image = UIImage(named: "fly")
        }else if self.ambassador!.name == "Exit" {
            skills[2].image = UIImage(named: "phone")
        }else if self.ambassador!.name == "Pill" {
            skills[5].image = UIImage(named: "pill")
        }else if self.ambassador!.name == "Kungfu" {
            skills[4].image = UIImage(named: "kungfu")
        }else if self.ambassador!.name == "Sunglasses" {
            skills[3].image = UIImage(named: "sunglasses")
        }else if self.ambassador!.name == "Spoon" {
            skills[7].image = UIImage(named: "spoon")
        }else if self.ambassador!.name == "bluePill" {
            skills[6].image = UIImage(named: "bluePill")
        }else if self.ambassador!.name == "bullets" {
            skills[0].image = UIImage(named:"bullets")
        }
    }
    
    private func tagFinder(tag:Int)->Int {
        switch tag {
        case 0:
            return loopOverAmbassadors(key: "bullets")
        case 1:
            return loopOverAmbassadors(key: "Rabbit")
        case 2:
            return loopOverAmbassadors(key: "Exit")
        case 3:
            return loopOverAmbassadors(key: "Sunglasses")
        case 4:
            return loopOverAmbassadors(key: "Kungfu")
        case 5:
            return loopOverAmbassadors(key: "Pill")
        case 6:
            return loopOverAmbassadors(key: "bluePill")
        case 7:
            return loopOverAmbassadors(key: "Spoon")
        case 8:
            return loopOverAmbassadors(key: "fly")
        default:
            return 0
        }
    }
    
    private func loopOverAmbassadors(key:String)->Int{
        for item in appDelegate.ambassadors {
            if item.name == key {
                return item.id
            }
        }
        return 0
    }
    
    private func restoreStoredSkill () {
        if AmbassadorCollector.defaultCollector.collectedAmbassadors.count > 0 {
            for item in AmbassadorCollector.defaultCollector.collectedAmbassadors {
                self.ambassador = item
                showGainSkill()
            }
            self.ambassador = nil
        }
    }
    
    //MARK:PRARManager Delegate
    func prarDidSetupAR(_ arView: UIView!, withCameraLayer cameraLayer: AVCaptureVideoPreviewLayer!, andRadarView radar: UIView!) {
        radarV = radar
        arV = arView
        view.layer.addSublayer(cameraLayer)
        view.addSubview(arView)
        view.bringSubview(toFront: view.viewWithTag(42313)!)
        view.addSubview(radar)
    }
    
    func prarUpdateFrame(_ arViewFrame: CGRect) {
        if view.viewWithTag(42313) != nil {
            view.viewWithTag(42313)!.frame = arViewFrame
        }
    }
    
    func prarGotProblem(_ problemTitle: String!, withDetails problemDetails: String!) {
        AlertCenter.throwAnAlert(title: problemTitle, message: problemDetails, completion: nil)
    }
    
    //MARK:LocationManagerDelegate 
    func showRabbit(_ ambassador:Ambassador) {
        guard ob!.rabbit.isHidden else {
            return
        }
        self.ambassador = ambassador
        for item in appDelegate.ambassadors {
            if item.name == ambassador.name {
                item.showed = true
                ambassador.showed = true
            }
        }
        if started {
            ob?.rabbit.isHidden = false
            if self.ambassador!.name == "Rabbit" {
                self.ob?.rabbit.loadGif(name: "rabbit")
            }else if self.ambassador!.name == "fly" {
                self.ob?.rabbit.loadGif(name: "fly")
            }else if self.ambassador!.name == "Exit" {
                self.ob?.rabbit.loadGif(name: "exit")
            }else if self.ambassador!.name == "Pill" {
                self.ob?.rabbit.loadGif(name: "pill")
            }else if self.ambassador!.name == "Kungfu" {
                self.ob?.rabbit.loadGif(name: "kungfu")
            }else if self.ambassador!.name == "Sunglasses" {
                self.ob?.rabbit.loadGif(name: "sunglasses")
            }else if self.ambassador!.name == "Spoon" {
                self.ob?.rabbit.loadGif(name: "spoon")
            }else if self.ambassador!.name == "bluePill" {
                self.ob?.rabbit.loadGif(name: "bluePill")
            }else if self.ambassador!.name == "bullets" {
                self.ob?.rabbit.loadGif(name: "bullets")
            }

            self.arManager?.showRadarSpots()
            AlertCenter.throwAnAlert(title: "Watch Out!",
                                     message: "Following the dot on the radar to find floating icon",
                                     completion: nil)
            feedBack(.beacon)
        }else {
            started = true
        }
    }
    
    func hideRabbit() {
        AlertCenter.throwAnAlert(title: "You are too far away from a skill",
                                 message: "Walk around to find floating skill icon",
                                 completion: nil)
    }
    
    func tapHandler(sender:UITapGestureRecognizer) {
        guard !fight else {
            let frame = view.convert((ob?.view.frame)!, from: ob?.view.superview)
            let agentForAnimation = UIImageView(frame: frame)
            agentForAnimation.image = UIImage(named: "smith_hit")
            view.addSubview(agentForAnimation)
            ob?.rabbit.isHidden = true
            UIView.animate(withDuration: 0.3, delay: 0.2, options: .curveEaseIn, animations: {
                agentForAnimation.frame = CGRect(x: UIScreen.main.bounds.width, y: 0, width: 1, height: 1)
            }, completion: { (success) in
                AlertCenter.throwAnAlert(title: "Victory!!!",
                                         message: "Check out",
                                         completion: {
                    DispatchQueue.main.async {
                        let des = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Result_VC")
                        self.navigationController!.pushViewController(des, animated: true)
                    }
                })
            })
            return
        }
        ob?.rabbit.isHidden = true
        feedBack(.success)
        showGainSkill()
        arManager?.hideRadarSpots()
        for item in appDelegate.ambassadors {
            if item.name == self.ambassador!.name {
                item.showed = true
                item.collected = true
                self.ambassador!.showed = true
                self.ambassador!.collected = true
            }
        }
        
        AmbassadorCollector.defaultCollector.collect(self.ambassador!)
        self.ambassador = nil
        AlertCenter.throwAnAlert(title: "Congratulations!",
                                 message: "You successfully gained a skill",
                                 completion: nil)
    }
    
    //MARK: Notification Handler
    func fightAgent(sender:Notification?){
        fight = true
        AmbassadorCollector.defaultCollector.gameOver = true
        AlertCenter.throwAnAlert(title: "Last Step",
                                 message: "Fight the Agent to win the game! If you don't see the agent, try to turn around!",
                                 completion: nil)
        ob?.rabbit.image = UIImage(named: "agent")
        ob?.rabbit.isHidden = false
    }
    
    func deallocateAR(sender:Notification?){
        gameTrigger.isEnabled = true
        ob?.rabbit.isHidden = true
        guard ob?.rabbit.gestureRecognizers?.last != nil else {
            return
        }
        ob?.rabbit.removeGestureRecognizer((ob?.rabbit.gestureRecognizers?.last)!)
        
        arV?.removeFromSuperview()
        radarV?.removeFromSuperview()
        guard view.layer.sublayers != nil else {return}
        for layer in view.layer.sublayers! {
            if layer is AVCaptureVideoPreviewLayer {
                layer.removeFromSuperlayer()
            }
        }
        containerView.isHidden = true
        arManager = nil
        LocationManger.defaultManager.delegate = nil
        started = false
        if  ambassador?.collected == false {
            for item in appDelegate.ambassadors {
                if item.name == ambassador?.name {
                    item.showed = false
                    ambassador?.showed = false
                }
            }
        }
        self.ambassador = nil
        
        //Preventing duplicate alerts for fighting agent
        if presentedViewController != nil {
            dismiss(animated: true, completion: nil)
        }
    }
}

extension HomeViewController: SkillDelegate {
    func shouldRestartGame() {
        startGame(gameTrigger)
    }
}

protocol PhysicalFeedbackDelegate {
    func feedBack(_ mode:SoundMode)
}

extension PhysicalFeedbackDelegate where Self: UIViewController {
    func feedBack(_ mode:SoundMode){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        guard mode != .success else {
            AudioServicesPlayAlertSound(1057)
            return
        }
        //Haptic feedback is possible, normal virberation for old devices
        if appDelegate.hapticDevice {
            if #available(iOS 10.0, *) {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.prepare()
                generator.impactOccurred()
            } else {
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
            }
        }else {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
        switch mode {
        case .error:
            AudioServicesPlayAlertSound(1073)
        case .beacon:
            AudioServicesPlayAlertSound(1070)
        default :
            break
        }
    }
}

enum SoundMode {
    case error
    case beacon
    case success
}
