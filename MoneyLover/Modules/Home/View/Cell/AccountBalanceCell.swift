//
//  AccountBalanceCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 17/03/2023.
//

import UIKit

class AccountBalanceCell: BaseTableViewCell {

  @IBOutlet weak var amountLabel: UILabel!
  @IBOutlet weak var eyesButton: UIButton!

  var accountBalance = ""
  var isShowAmount = true

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  @IBAction func eyesButtonAction(_ sender: Any) {
    isShowAmount = !isShowAmount
    if isShowAmount {
      performAmount(accountBalance: accountBalance + Resource.Title.vnd)
      eyesButton.setImage(Resource.Image.openEyes, for: .normal)
    } else {
      performAmount(accountBalance: Resource.Title.passwordText + Resource.Title.vnd)
      eyesButton.setImage(Resource.Image.closeEyes, for: .normal)
    }
  }

  func performAmount(accountBalance: String) {
    amountLabel.text = accountBalance
  }

}
