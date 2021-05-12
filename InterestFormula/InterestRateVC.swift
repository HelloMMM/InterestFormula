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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loanAmount.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        monthMonry.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        loanMonth.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        
        var newText = textField.text!.replacingOccurrences(of: ",", with: "")
        
        if newText.count > 11 {
            newText.removeLast()
        }
        
        textField.text = setInterval(text: newText)
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
        
        view.endEditing(true)
        
        let newLoanAmount = loanAmount.text!.replacingOccurrences(of: ",", with: "")
        let newMonthMonry = monthMonry.text!.replacingOccurrences(of: ",", with: "")
        let newLoanMonth = loanMonth.text!.replacingOccurrences(of: ",", with: "")
        
        if newLoanAmount == "0" || newMonthMonry == "0" || newLoanMonth == "0" || loanAmount.text == "" || loanMonth.text == "" || monthMonry.text == "" {
            
            let alert = UIAlertController(title: nil, message: "輸入資料有誤", preferredStyle: .alert)
            let ok = UIAlertAction(title: "確定", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        if !isRemoveAD {
            let tabbar = tabBarController as! TabBarVC
            tabbar.showInterstitial()
        }
        
        let monthMoney = Int(newLoanAmount)! / Int(newLoanMonth)!
        let averageBalance = Double(Double(newLoanAmount)! + Double(monthMoney)) / 2
        
        let interest = Float(newMonthMonry)! * Float(newLoanMonth)! - Float(newLoanAmount)!
        
        let year = Float(newLoanMonth)! / 12
        
        let interestRate = ((interest / Float(averageBalance)) * 100) / year
        
        interestResult.text = String(format: "%.1f", interestRate)
    }
    
    func setInterval(text: String) -> String {
        
        let newText = text.replacingOccurrences(of: ",", with: "")
        
        let formatter = NumberFormatter().number(from: newText) ?? 0
        let formattedText = NumberFormatter.localizedString(from: formatter, number: .decimal)
        
        return formattedText
    }
}
