//
//  NVLoadingView.swift
//  JPWApp
//
//  Created by HellöM on 2020/2/26.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
//import NVActivityIndicatorView

class NVLoadingView {

    static let shared = NVLoadingView()
//    var activityIndicatorView: NVActivityIndicatorView?
    
    func startBlockLoadingView() {
        
//        activityIndicatorView = NVActivityIndicatorView(frame: UIScreen.main.bounds, type: .ballPulseSync, color: nil, padding: nil)
//        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(activityIndicatorView!)
//        activityIndicatorView?.startAnimating()
//        let activityData = ActivityData(size: nil, message: nil, messageFont: nil, messageSpacing: nil, type: .ballPulseSync, color: nil, padding: nil, displayTimeThreshold: nil, minimumDisplayTime: nil, backgroundColor: nil, textColor: nil)
//
//        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    func stopBlockLoadingView() {
        
//        activityIndicatorView?.stopAnimating()
//        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
    }
}
