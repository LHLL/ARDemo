//
//  TodayViewController.swift
//  NSC Widget
//
//  Created by Xu, Jay on 1/4/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController {
        
    @IBOutlet weak var skillTable: UICollectionView!
    
    var imageNames = [String]()
    var iconWidth:CGFloat = 0
    var iconHeight:CGFloat = 0
    //Share data with main app
    let userDefaults = UserDefaults(suiteName: "group.com.wf.NSC")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skillTable.register(UINib(nibName: "SkillCell", bundle: nil), forCellWithReuseIdentifier: "WidgetCell")
        //Following numbers are resolution of assets
        iconWidth = (UIScreen.main.bounds.width - 96)/9
        iconHeight = 1154 * iconWidth / 592
        //Make sure image is on the center of view. Since compact mode is fixed to be 110 by Apple, it is OK for us to hardcode numbers
        (skillTable.collectionViewLayout as! UICollectionViewFlowLayout).sectionInset.top = 10
        
        if #available(iOSApplicationExtension 10.0, *) {
            extensionContext?.widgetLargestAvailableDisplayMode = .expanded
        } else {
            //very sadly, we don't have plan B for iOS 9 or older. They will look exactly same though except for expending, who needs expand?
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TodayViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WidgetCell", for: indexPath) as! SkillCell
        if indexPath.item < imageNames.count {
            cell.skillImage.image = UIImage(named: imageNames[indexPath.item])
        }else {
            cell.skillImage.image = UIImage(named: "blank")
        }
        return cell
    }
}

extension TodayViewController:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: iconWidth, height: iconHeight)
    }
}

extension TodayViewController:NCWidgetProviding {
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        imageNames.removeAll()
        if userDefaults.value(forKey: "name") != nil {
            
            if userDefaults.value(forKey: "ambassador") != nil {
                let ams = userDefaults.value(forKey: "ambassador") as! [[Any]]
                
                for index in 0..<ams[0].count {
                    switch (ams[0][index] as! String) {
                    case "Rabbit":
                        imageNames.append("rabbit")
                    case "fly":
                        imageNames.append("fly")
                    case "Exit":
                        imageNames.append("phone")
                    case "Pill":
                        imageNames.append("pill")
                    case "Kungfu":
                        imageNames.append("kungfu")
                    case "Sunglasses":
                        imageNames.append("sunglasses")
                    case "Spoon":
                        imageNames.append("spoon")
                    case "bluePill":
                        imageNames.append("bluePill")
                    case "bullets":
                        imageNames.append("bullets")
                    default:
                        break
                    }
                }
                
                skillTable.reloadData()
            }
            completionHandler(NCUpdateResult.newData)
        }else {
            completionHandler(.noData)
        }
    }
    
    @available(iOSApplicationExtension 10.0, *)
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if activeDisplayMode == .compact {
            preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 110)
        }else {
            preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 156)
        }
    }
}
