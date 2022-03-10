//
//  AppDelegate.swift
//  InterestFormula
//
//  Created by HellöM on 2020/4/27.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AppTrackingTransparency

var isRemoveAD: Bool = false
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        AlaomfireManager.postAPI {}
        let _ = IAPManager.shared
        
        if let removeAD = UserDefaults.standard.object(forKey: "isRemoveAD") {
            
            isRemoveAD = removeAD as! Bool
        }

        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                GADMobileAds.sharedInstance().start(completionHandler: nil)
            })
        } else {
            GADMobileAds.sharedInstance().start(completionHandler: nil)
        }

        return true
    }   
}
