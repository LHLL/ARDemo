//
//  ResultViewController.swift
//  NSC
//
//  Created by Xu, Jay on 12/19/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var confiramtionLabel: UILabel!
    @IBOutlet weak var congratulationView: UIImageView!
    @IBOutlet weak var cleanButton: UIButton!
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    private var shouldHideStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    private let charactersSet = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","0","1","2","3","4","5","6","7","8","9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shouldHideStatusBar = true
        navigationController?.navigationBar.isHidden = true
        if AmbassadorCollector.defaultCollector.confirmationCode != nil {
            if AmbassadorCollector.defaultCollector.confirmationCode == "" {
                var str = confiramtionLabel.text
                str?.append("\n\n Confirmation Code: \n")
                str?.append(confirmationCodeGenerator())
                AmbassadorCollector.defaultCollector.confirmationCode = str!
            }
            confiramtionLabel.text = AmbassadorCollector.defaultCollector.confirmationCode
        }else {
            var str = confiramtionLabel.text
            str?.append("\n\n Confirmation Code: \n")
            str?.append(confirmationCodeGenerator())
            AmbassadorCollector.defaultCollector.confirmationCode = str!
            confiramtionLabel.text = AmbassadorCollector.defaultCollector.confirmationCode
        }
    }

    //Confirmation Code is generated in case there is no internet access or slow wifi that will cause http request time out
    private func confirmationCodeGenerator() -> String {
        var str = ""
        while str.characters.count <= 8 {
            let index = arc4random_uniform(62)
            str.append(charactersSet[Int(index)])
        }
        return str
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Action Trigger
    @IBAction func showConfirmationCode(_ sender: UITapGestureRecognizer) {
        showConfirmation()
    }
    
    //Andrew L Martinez method, only uncomment line 89 when you demo this app to Andrew
    @IBAction func cleanCache(_ sender: UIButton) {
        let alert = UIAlertController(title: "Pass Code", message: "Enter Pass Phase", preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.keyboardType = .numberPad
        }
        let dismiss = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let done = UIAlertAction(title: "Done", style: .default) { (action) in
            if alert.textFields?[0].text == "123456" {
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let home = sb.instantiateViewController(withIdentifier: "Welcome_VC")
                self.navigationController!.pushViewController(home, animated: true)
                
                if let bundle = Bundle.main.bundleIdentifier {
                    UserDefaults(suiteName: "group.com.wf.NSC")!.removePersistentDomain(forName: bundle)
                }
                
                AmbassadorCollector.defaultCollector.clean()
            }
        }
        alert.addAction(dismiss)
        alert.addAction(done)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: UI Configuration
    func showConfirmation () {
        confiramtionLabel.isHidden = false
        congratulationView.isHidden = true
        AmbassadorCollector.defaultCollector.gameOver = true
        //cleanButton.isHidden = false
    }
    
}
