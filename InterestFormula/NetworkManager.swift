//
//  NetworkManager.swift
//  InterestFormula
//
//  Created by HellöM on 2022/4/15.
//  Copyright © 2022 HellöM. All rights reserved.
//

import Foundation
import Network

@available(iOS 12.0, *)
class NetworkManager {
    
    static let shared = NetworkManager()
    var monitor: NWPathMonitor!
    var isNetwork = false
    var netStatusChangeHandler: ((Bool) -> ())?
    
    init() {
        monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                AlaomfireManager.postAPI {}
            }
        }
        
        monitor.start(queue: DispatchQueue.global())
    }
}
