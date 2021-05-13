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
    var repaymentOfTotal: Double = 0
    var calculationType: CalculationType = .principal
    
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
        
        monthRate = (yearInterestRate/100) / 12
        
        interestRepaymentArray = Array(repeating: 0, count: Int(loanMonth))
        totalArray = Array(repeating: 0, count: Int(loanMonth))
        loanBalanceArray = Array(repeating: 0, count: Int(loanMonth))
        repaymentOfPrincipalArray = Array(repeating: 0, count: Int(loanMonth))
        repaymentOfPrincipalAndInterestArray = Array(repeating: 0, count: Int(loanMonth))
        
        switch calculationType {
        case .principal:
            computerPrincipal()
        case .interest:
            computerInterest()
        }
        
    }
    
    func computerPrincipal() {
        
        repaymentOfPrincipal = Int(loanAmount / loanMonth)
        
        for index in 0...Int(loanMonth)-1 {
            
            let paid = repaymentOfPrincipal * (index + 1)
            let loanBalance = Int(loanAmount) - paid
            
            let paidInterest = repaymentOfPrincipal * index
            let loanBalanceInterest = Int(loanAmount) - paidInterest
            let interest = Int(Double(loanBalanceInterest) * monthRate)
            interestRepaymentArray[index] = interest
            
            if loanBalance < repaymentOfPrincipal {
                loanBalanceArray[index] = 0
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
    
    func computerInterest() {
        
        let monthAverageInterestRate = (pow(1 + monthRate, loanMonth) * monthRate) / (pow(1 + monthRate, loanMonth) - 1)
        repaymentOfTotal = loanAmount * monthAverageInterestRate
        total = Int(repaymentOfTotal * loanMonth)
        interestTotal = total - Int(loanAmount)
        
        for index in 0...Int(loanMonth)-1 {
            let paid = Int(repaymentOfTotal) * (index + 1)
            let loanBalance = total - paid
            loanBalanceArray[index] = loanBalance
            let monthInterest = Double(loanBalance) * monthRate
            interestRepaymentArray[index] = Int(monthInterest)
            let monthRepaymentOfPrincipal = repaymentOfTotal - monthInterest
            repaymentOfPrincipalArray[index] = Int(monthRepaymentOfPrincipal)
            
            if loanBalance < Int(repaymentOfTotal) {
                repaymentOfPrincipalArray[index] = Int(monthRepaymentOfPrincipal) + loanBalance
                loanBalanceArray[index] = 0
            }
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
        
        switch calculationType {
        case .principal:
            cell.repaymentOfPrincipal.text = "\(repaymentOfPrincipal)"
            cell.interestRepayment.text = "\(interestRepaymentArray[indexPath.row])"
            cell.repaymentOfPrincipalAndInterest.text = "\(repaymentOfPrincipalAndInterestArray[indexPath.row])"
            cell.loanBalance.text = "\(loanBalanceArray[indexPath.row])"
        case .interest:
            cell.repaymentOfPrincipal.text = "\(repaymentOfPrincipalArray[indexPath.row])"
            cell.interestRepayment.text = "\(interestRepaymentArray[indexPath.row])"
            if indexPath.row == interestRepaymentArray.count-1 {
                cell.repaymentOfPrincipalAndInterest.text = "\(repaymentOfPrincipalArray[indexPath.row])"
            } else {
                cell.repaymentOfPrincipalAndInterest.text = "\(Int(repaymentOfTotal))"
            }
            cell.loanBalance.text = "\(loanBalanceArray[indexPath.row])"
        }
        
        return cell
    }
}
