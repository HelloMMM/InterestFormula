//
//  CalculationVC.swift
//  InterestFormula
//
//  Created by HellöM on 2020/4/27.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class CalculationVC: UIViewController {
    
    var loanAmount: Double!
    var loanMonth: Double!
    var yearInterestRate: Double!
    
    var averageRate: Double = 0
    var monthRate: Double = 0
    var repaymentOfPrincipal: Int = 0
    
    var total: Int = 0 {
        didSet {
            totalLab.text = setInterval(text: "\(total)")
        }
    }
    
    var interestTotal: Int = 0 {
        didSet {
            interestTotalLab.text = setInterval(text: "\(interestTotal)")
        }
    }
    
    var interestRepaymentArray: Array<Int>!
    var totalArray: Array<Int>!
    var loanBalanceArray: Array<Int>!
    var repaymentOfPrincipalArray: Array<Int>!
    var repaymentOfPrincipalAndInterestArray: Array<Int>!
    
    @IBOutlet weak var totalLab: UILabel!
    @IBOutlet weak var interestTotalLab: UILabel!
    @IBOutlet weak var spacing: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "試算表"
        
        repaymentOfPrincipal = Int(loanAmount / loanMonth)
        monthRate = (yearInterestRate/100) / 12
        
        interestRepaymentArray = Array(repeating: 0, count: Int(loanMonth))
        totalArray = Array(repeating: 0, count: Int(loanMonth))
        loanBalanceArray = Array(repeating: 0, count: Int(loanMonth))
        repaymentOfPrincipalArray = Array(repeating: 0, count: Int(loanMonth))
        repaymentOfPrincipalAndInterestArray = Array(repeating: 0, count: Int(loanMonth))
        
        computerTotal()
    }
    
    func computerTotal() {
        
        for index in 0...Int(loanMonth)-1 {
            
            let paid = repaymentOfPrincipal * (index + 1)
            let loanBalance = Int(loanAmount) - paid
            
            let paidInterest = repaymentOfPrincipal * index
            let loanBalanceInterest = Int(loanAmount) - paidInterest
            let interest = Int(Double(loanBalanceInterest) * monthRate)
            interestRepaymentArray[index] = interest
            
            if loanBalance < repaymentOfPrincipal {
                loanBalanceArray[index] = 0
                repaymentOfPrincipalArray[index] = repaymentOfPrincipal + loanBalance
                repaymentOfPrincipalAndInterestArray[index] = repaymentOfPrincipal + interest + loanBalance
            } else {
                loanBalanceArray[index] = loanBalance
                repaymentOfPrincipalAndInterestArray[index] = repaymentOfPrincipal + interest
            }
        }
        
        for money in repaymentOfPrincipalAndInterestArray{
            
            total += money
        }
        
        for money in interestRepaymentArray {
            
            interestTotal += money
        }
    }
    
    func setInterval(text: String) -> String {
        
        let newText = text.replacingOccurrences(of: ",", with: "")
        
        let formatter = NumberFormatter().number(from: newText)!
        let formattedText = NumberFormatter.localizedString(from: formatter, number: .decimal)
        
        return formattedText
    }
}

extension CalculationVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(loanMonth)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CalculationCell
        
        cell.period.text = "\(indexPath.row+1)"
        cell.repaymentOfPrincipal.text = "\(repaymentOfPrincipal)"
        cell.interestRepayment.text = "\(interestRepaymentArray[indexPath.row])"
        cell.repaymentOfPrincipalAndInterest.text = "\(repaymentOfPrincipalAndInterestArray[indexPath.row])"
        cell.loanBalance.text = "\(loanBalanceArray[indexPath.row])"
        return cell
    }
}
