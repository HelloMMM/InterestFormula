//
//  AlaomfireManager.swift
//  CurrencyConverter
//
//  Created by HellöM on 2020/4/30.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import Alamofire



class AlaomfireManager: NSObject {

    class func postAPI(success:@escaping () -> ()) {
        
        AF.request("https://tw.rter.info/capi.php", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor: nil).responseJSON { (response) in
            
            switch response.result {
                
            case .success(let json):
                
                let responseJson = json as! Dictionary<String, Any>
//                print(responseJson)
                currencyValueModel = responseJson
                success()
            case .failure(let error):
                
                print(error.localizedDescription)
            }
        }
    }
}
