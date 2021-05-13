//
//  ViewController.swift
//  InterestFormula
//
//  Created by HellöM on 2020/4/27.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import GoogleMobileAds

enum CalculationType {
    case principal
    case interest
}

class LoanVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loanAmount: UITextField!
    @IBOutlet weak var loanMonth: UITextField!
    @IBOutlet weak var yearInterestRate: UITextField!
    @IBOutlet weak var calculationSegment: UISegmentedControl!
    private var calculationType: CalculationType = .principal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loanAmount.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        loanMonth.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
        yearInterestRate.addTarget(self, action: #selector(textFieldChange(_:)), for: .editingChanged)
    }
    
    @objc func textFieldChange(_ textField: UITextField) {
        
        var newText = textField.text!.replacingOccurrences(of: ",", with: "")
        
        if newText.count > 11 {
            newText.removeLast()
        }
        
        if textField == yearInterestRate {
            
            textField.text = newText
        } else {
            textField.text = setInterval(text: newText)
        }
    }
    
    @IBAction func calculationTypeAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            calculationType = .principal
        case 1:
            calculationType = .interest
        default: break
        }
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
        
        let newLoanAmount = loanAmount.text!.replacingOccurrences(of: ",", with: "")
        let newLoanMonth = loanMonth.text!.replacingOccurrences(of: ",", with: "")
        let newYearInterestRate = Double(yearInterestRate.text!) ?? 0
        
        if loanAmount.text == "" || loanMonth.text == "" || yearInterestRate.text == "" || loanAmount.text == "0" || loanMonth.text == "0" || yearInterestRate.text == "0" {
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
        
        let calculationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalculationVC") as! CalculationVC
        
        if newYearInterestRate == 0 {
            
            let alert = UIAlertController(title: nil, message: "輸入資料有誤", preferredStyle: .alert)
            let ok = UIAlertAction(title: "確定", style: .cancel, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        calculationVC.loanAmount = Double(newLoanAmount)!
        calculationVC.loanMonth = Double(newLoanMonth)
        calculationVC.yearInterestRate = newYearInterestRate
        calculationVC.calculationType = calculationType
        
        navigationController?.pushViewController(calculationVC, animated: true)
    }
    
    func setInterval(text: String) -> String {
        
        let newText = text.replacingOccurrences(of: ",", with: "")
        
        let formatter = NumberFormatter().number(from: newText) ?? 0
        let formattedText = NumberFormatter.localizedString(from: formatter, number: .decimal)
        
        return formattedText
    }
    
}

