//
//  CurrencyValueModel.swift
//  CurrencyConverter
//
//  Created by HellöM on 2020/4/30.
//  Copyright © 2020 HellöM. All rights reserved.
//

import Foundation

var currencyValueModel: Dictionary<String, Any>? {
    set {
        UserDefaults.standard.set(newValue, forKey: "currencyValueModel")
        UserDefaults.standard.synchronize()
    }
    
    get {
        if let model = UserDefaults.standard.dictionary(forKey: "currencyValueModel") {
            return model
        } else {
            return nil
        }
    }
}
