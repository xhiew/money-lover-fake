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

	var accountBalance: Double {
		return UserDefaults.standard.accountBalance
	}

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
		handleBlink()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  @IBAction func eyesButtonAction(_ sender: Any) {
		UserDefaults.standard.isHiddenAmount = !UserDefaults.standard.isHiddenAmount
		NotificationCenter.default.post(name: .blink, object: nil)
		handleBlink()
  }

	private func handleBlink() {
		if UserDefaults.standard.isHiddenAmount {
			performAmount(accountBalance: Resource.Title.privateAmount + " " + Resource.Title.vnd)
			eyesButton.setImage(Resource.Image.closeEyes, for: .normal)
		} else {
			performAmount(accountBalance: accountBalance.formatMoneyNumber() + " " + Resource.Title.vnd)
			eyesButton.setImage(Resource.Image.openEyes, for: .normal)
		}
	}

  func performAmount(accountBalance: String) {
    amountLabel.text = accountBalance
  }

}
