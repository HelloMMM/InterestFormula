//
//  TabBarVC.swift
//  InterestFormula
//
//  Created by HellöM on 2020/5/4.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import GoogleMobileAds



class TabBarVC: UITabBarController {

    var bannerView: GADBannerView!
    var loanVC: LoanVC!
    var interestRateVC: InterestRateVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeAD), name: NSNotification.Name("RemoveAD") , object: nil)
        
        
        if !isRemoveAD {
            addBannerViewToView()
        }
    }
    
    @objc func removeAD(notification: NSNotification) {
            
        isRemoveAD = true
        
        if bannerView != nil {
            bannerView.removeFromSuperview()
        }
    }
    
    func addBannerViewToView() {
        
        bannerView = GADBannerView(adSize: kGADAdSizeFullBanner)
        
        #if DEBUG
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        #else
        bannerView.adUnitID = "ca-app-pub-1223027370530841/9181620486"
        #endif

        bannerView.delegate = self
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bannerView)
        bannerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: 0).isActive = true
        bannerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        bannerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor, constant: 0).isActive = true
    }
}

extension TabBarVC: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }
}
