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
        default:
            break
        }
    }
}
