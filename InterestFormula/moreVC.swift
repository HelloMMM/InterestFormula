//
//  moreVC.swift
//  InterestFormula
//
//  Created by HellöM on 2020/5/26.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class moreVC: UITableViewController {

    override func viewDidLoad() {
        
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            let _ = IAPManager.shared.startPurchase()
        case 1:
            let _ = IAPManager.shared.restorePurchase()
        case 3:
            let urlString =  "itms-apps:itunes.apple.com/us/app/apple-store/id1510872754?mt=8&action=write-review"
            let url = URL(string: urlString)!
            UIApplication.shared.open(url, completionHandler: nil)
        default:
            break
        }
    }
}
