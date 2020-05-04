//
//  InterestRateVC.swift
//  InterestFormula
//
//  Created by HellöM on 2020/4/28.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import GoogleMobileAds

class InterestRateVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loanAmount: UITextField!
    @IBOutlet weak var monthMonry: UITextField!
    @IBOutlet weak var loanMonth: UITextField!
    @IBOutlet weak var interestResult: UILabel!
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        interstitial = createAndLoadInterstitial()
    }
    
    func createAndLoadInterstitial() -> GADInterstitial {
        
        #if DEBUG
            interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        #else
            interstitial = GADInterstitial(adUnitID: "ca-app-pub-1223027370530841/1810875858")
        #endif
        interstitial.delegate = self
        interstitial.load(GADRequest())
        
        return interstitial
    }
    
    @IBAction func clearClick(_ sender: UIButton) {
        
        loanAmount.text = ""
        monthMonry.text = ""
        loanMonth.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    @IBAction func computer(_ sender: UIButton) {
        
        if loanAmount.text == "" || loanMonth.text == "" || monthMonry.text == "" {
            return
        }
    
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            interstitial = createAndLoadInterstitial()
        }
        
        let newLoanAmount = loanAmount.text!.replacingOccurrences(of: ",", with: "")
        let newMonthMonry = monthMonry.text!.replacingOccurrences(of: ",", with: "")
        let newLoanMonth = loanMonth.text!.replacingOccurrences(of: ",", with: "")
        
        let monthMoney = Int(newLoanAmount)! / Int(newLoanMonth)!
        let averageBalance = Double(Double(newLoanAmount)! + Double(monthMoney)) / 2
        
        let interest = Float(newMonthMonry)! * Float(newLoanMonth)! - Float(newLoanAmount)!
        
        let year = Float(newLoanMonth)! / 12
        
        let interestRate = ((interest / Float(averageBalance)) * 100) / year
        
        interestResult.text = String(format: "%.1f", interestRate)
    }
    
    func setInterval(text: String) -> String {
        
        let newText = text.replacingOccurrences(of: ",", with: "")
        
        let formatter = NumberFormatter().number(from: newText)!
        let formattedText = NumberFormatter.localizedString(from: formatter, number: .decimal)
        
        return formattedText
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == loanMonth {
            return
        } else {
            if textField.text == "" { return }
            
            textField.text = setInterval(text: textField.text!)
        }
    }
}

extension InterestRateVC: GADInterstitialDelegate {
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {

        interstitial = createAndLoadInterstitial()
    }
}
