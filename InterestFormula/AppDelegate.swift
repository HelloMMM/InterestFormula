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
        if #available(iOS 12.0, *) {
            let _ = NetworkManager.shared
        }
        let _ = IAPManager.shared
        
        if let removeAD = UserDefaults.standard.object(forKey: "isRemoveAD") {
            
            isRemoveAD = removeAD as! Bool
        }

        GADMobileAds.sharedInstance().start(completionHandler: nil)

        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in })
        }
    }
}
