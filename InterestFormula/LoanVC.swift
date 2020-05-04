//
//  ViewController.swift
//  InterestFormula
//
//  Created by HellöM on 2020/4/27.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import GoogleMobileAds

class LoanVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loanAmount: UITextField!
    @IBOutlet weak var loanMonth: UITextField!
    @IBOutlet weak var yearInterestRate: UITextField!
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
        loanMonth.text = ""
        yearInterestRate.text = ""
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        view.endEditing(true)
    }
    
    @IBAction func computer(_ sender: UIButton) {
        
        view.endEditing(true)
        
        if loanAmount.text == "" || loanMonth.text == "" || yearInterestRate.text == "" {
            return
        }
        
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
        } else {
            interstitial = createAndLoadInterstitial()
        }
        
        let calculationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalculationVC") as! CalculationVC
        
        calculationVC.loanAmount = Double(loanAmount.text!.replacingOccurrences(of: ",", with: ""))!
        calculationVC.loanMonth = Double(loanMonth.text!)
        calculationVC.yearInterestRate = Double(yearInterestRate.text!)
        
        navigationController?.pushViewController(calculationVC, animated: true)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == loanAmount {
            if textField.text == "" { return }
            
            textField.text = setInterval(text: textField.text!)
        }
    }
    
    func setInterval(text: String) -> String {
        
        let newText = text.replacingOccurrences(of: ",", with: "")
        
        let formatter = NumberFormatter().number(from: newText)!
        let formattedText = NumberFormatter.localizedString(from: formatter, number: .decimal)
        
        return formattedText
    }
    
}

extension LoanVC: GADInterstitialDelegate {
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {

        interstitial = createAndLoadInterstitial()
    }
}
