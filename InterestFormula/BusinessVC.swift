//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by HellöM on 2020/4/30.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class BusinessVC: UIViewController {

    @IBOutlet weak var currency1: UIButton!
    @IBOutlet weak var currency2: UIButton!
    @IBOutlet weak var currencyText1: UITextField!
    @IBOutlet weak var currencyText2: UITextField!
    @IBOutlet weak var changeBtn: UIButton!
    
    let countryCode = ["USDTWD", "USDHKD", "USDCNY",
                       "USD", "USDEUR", "USDAUD",
                       "USDJPY", "USDKRW", "USDTHB", "USDMYR"]
    let country = ["🇹🇼台幣 TWD", "🇭🇰港幣 HKD", "🇨🇳人民幣 CNY",
                   "🇺🇸美金 USD", "🇪🇺歐元 EUR", "🇦🇺澳元 AUD",
                   "🇯🇵日圓 JPY", "🇰🇷韓元 KRW", "🇹🇭泰銖 THB", "🇬🇧英鎊 MYR"]
    
    var country1 = "USDTWD"
    var country2 = "USD"
    var country1Extate: Double = 0
    var country2Extate: Double = 0
    var currency1LastSelect = 0
    var currency2LastSelect = 3
    var isZero = false
    var isPoint = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        currencyText1.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        currencyText2.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        
        setExrate()
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        
        if textField == currencyText1 {
            calculation1()
        } else {
            calculation2()
        }
    }
    
    func setExrate() {
        
        if country1 == "USD" {
            country1Extate = 1
        } else {
            country1Extate = (currencyValueModel[country2] as! Dictionary<String, Any>)["Exrate"] as! Double
        }
        
        if country2 == "USD" {
            country2Extate = 1
        } else {
            country2Extate = (currencyValueModel[country1] as! Dictionary<String, Any>)["Exrate"] as! Double
        }
    }
    
    @IBAction func exchange(_ sender: UIButton) {
        
        let exchangeExtate = country1Extate
        country1Extate = country2Extate
        country2Extate = exchangeExtate
        
        let exchangeSelect = currency1LastSelect
        currency1LastSelect = currency2LastSelect
        currency2LastSelect = exchangeSelect
        
        country1 = countryCode[currency1LastSelect]
        country2 = countryCode[currency2LastSelect]
        
        currency1.setTitle(country[currency1LastSelect], for: .normal)
        currency2.setTitle(country[currency2LastSelect], for: .normal)
        
        if currencyText1.text == "" || currencyText2.text == "" {
            return
        }
        calculation1()
    }
    
    @IBAction func currency1Click(_ sender: UIButton) {
        
        view.endEditing(true)
        
        let customPickerView = CustomPickerView(country) { (countryNumber) in
            
            sender.setTitle(self.country[countryNumber], for: .normal)
            self.currency1LastSelect = countryNumber
            self.country1 = self.countryCode[countryNumber]
            
            self.setExrate()
            self.calculation1()
        }
        
        customPickerView.lastSelect = currency1LastSelect
    }
    
    @IBAction func currency2Click(_ sender: UIButton) {
        
        view.endEditing(true)
        
        let customPickerView = CustomPickerView(country) { (countryNumber) in
            
            sender.setTitle(self.country[countryNumber], for: .normal)
            self.currency2LastSelect = countryNumber
            self.country2 = self.countryCode[countryNumber]
            
            self.setExrate()
            self.calculation2()
        }
        
        customPickerView.lastSelect = currency2LastSelect
    }
    
    func calculation1() {
        let moneyUSD = Float(currencyText1.text!) ?? 0 / Float(country1Extate)
        
        print("\(moneyUSD) \(country2Extate)")
        let money = moneyUSD * Float(country2Extate)
        currencyText2.text = String(format: "%.3f", money)
    }
    
    func calculation2() {
        let moneyUSD = Float(currencyText2.text!) ?? 0 / Float(country2Extate)
        let money = moneyUSD * Float(country1Extate)
        currencyText1.text = String(format: "%.3f", money)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension BusinessVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text == "0" {
           
            textField.text = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.text == "" {
            
            textField.text = "0"
            isZero = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField.text == "0" {
            
            if range.location == 0 {
                return true
            }
            
            if string != "." {
                return false
            }
        }
        
        if string == "." {
            
            if isPoint {
                return false
            } else {
                isPoint = true
                
                if textField.text == "" {
                    textField.text = "0"
                }
            }
        }
        
        let s = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if !s.contains(".") {
            isPoint = false
        }
        
        return true
    }
    
//    func textFieldDidChangeSelection(_ textField: UITextField) {
//
//        if textField == currencyText1 {
//
//            if textField.text == "0" || textField.text == "" || textField.text == "."{
//
//                textField.text = ""
//                currencyText2.text = "0"
//                return
//            }
//
//            calculation1()
//        } else {
//
//            if textField.text == "0" || textField.text == "" || textField.text == "."{
//
//                textField.text = ""
//                currencyText1.text = "0"
//                return
//            }
//
//            calculation2()
//        }
//    }
}
