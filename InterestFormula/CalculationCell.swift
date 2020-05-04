//
//  CalculationCell.swift
//  InterestFormula
//
//  Created by HellöM on 2020/4/27.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit

class CalculationCell: UITableViewCell {

    @IBOutlet weak var period: UILabel!
    @IBOutlet weak var repaymentOfPrincipal: UILabel!
    @IBOutlet weak var interestRepayment: UILabel!
    @IBOutlet weak var repaymentOfPrincipalAndInterest: UILabel!
    @IBOutlet weak var loanBalance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
