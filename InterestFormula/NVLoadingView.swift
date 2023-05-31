//
//  NVLoadingView.swift
//  JPWApp
//
//  Created by HellöM on 2020/2/26.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class NVLoadingView {

    static let shared = NVLoadingView()
    var activityIndicatorView: NVActivityIndicatorView!
    var blockerView: UIView?
    
    init() {
        blockerView = UIView(frame: UIScreen.main.bounds)
        blockerView?.backgroundColor = .black
        blockerView?.alpha = 0
        
        activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 50), type: .ballPulseSync)
        activityIndicatorView.center = blockerView?.center ?? .zero
        blockerView?.addSubview(activityIndicatorView)
        
        UIApplication.shared.keyWindow?.rootViewController?.view.addSubview(blockerView!)
    }
    
    func startBlockLoadingView() {
        blockerView?.alpha = 0.5
        activityIndicatorView.startAnimating()
    }
    
    func stopBlockLoadingView() {
        blockerView?.alpha = 0
        activityIndicatorView.stopAnimating()
        blockerView?.removeFromSuperview()
    }
}
