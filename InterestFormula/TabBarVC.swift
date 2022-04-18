//
//  TabBarVC.swift
//  InterestFormula
//
//  Created by HellöM on 2020/5/4.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import GoogleMobileAds

class TabBarVC: UITabBarController, UITabBarControllerDelegate {

    var bannerView: GADBannerView!
    var interstitial: GADInterstitialAd?
    var loanVC: LoanVC!
    var interestRateVC: InterestRateVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeAD), name: NSNotification.Name("RemoveAD") , object: nil)
        
        if !isRemoveAD {
            addBannerViewToView()
        }
        
        createAndLoadInterstitial()
    }
    
    @objc func removeAD(notification: NSNotification) {
            
        isRemoveAD = true
        
        if bannerView != nil {
            bannerView.removeFromSuperview()
        }
    }
    
    func showInterstitial() {
        if interstitial != nil {
            interstitial!.present(fromRootViewController: self)
        }
    }
    
    func addBannerViewToView() {
        
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        view.addSubview(bannerView)
        bannerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: 0).isActive = true
        bannerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        bannerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        bannerView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor, constant: 0).isActive = true
        
        #if DEBUG
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        #else
        bannerView.adUnitID = "ca-app-pub-1223027370530841/9181620486"
        #endif

        bannerView.delegate = self
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    func createAndLoadInterstitial() {
        
        let request = GADRequest()
        var adUnitID = ""
        #if DEBUG
            adUnitID = "ca-app-pub-3940256099942544/4411468910"
        #else
            adUnitID = "ca-app-pub-1223027370530841/1810875858"
        #endif
        
        GADInterstitialAd.load(withAdUnitID: adUnitID, request: request) { [self] ad, error in
            if error == nil {
                interstitial = ad
                interstitial?.fullScreenContentDelegate = self
            }
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        guard let index = tabBarController.viewControllers?.enumerated().first(where: { $0.element == viewController })?.offset else { return true }
        
        switch index {
        case 2:
            if currencyValueModel == nil {
                let alert = UIAlertController(title: "注意", message: "貨幣轉換需要網路功能, 請開啟網路後再試一次.", preferredStyle: .alert)
                let confirm = UIAlertAction(title: "確認", style: .default, handler: nil)
                alert.addAction(confirm)
                
                present(alert, animated: true, completion: nil)
                return false
            }
        default: break
        }
        
        return true
    }
}

extension TabBarVC: GADBannerViewDelegate {
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
}

extension TabBarVC: GADFullScreenContentDelegate {
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }
    
    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
    }
    
    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        createAndLoadInterstitial()
    }
}
