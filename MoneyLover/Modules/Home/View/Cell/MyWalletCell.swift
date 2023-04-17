//
//  MyWalletCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 17/03/2023.
//

import UIKit

class MyWalletCell: BaseTableViewCell {

	@IBOutlet weak var amountLabel: UILabel!

	var currentAmount: Double = 0 {
		didSet {
			checkEyes()
		}
	}

	var changeAmount: (() -> Void)?

	override func awakeFromNib() {
		super.awakeFromNib()
		NotificationCenter.default.addObserver(self, selector: #selector(handlePerformAmount), name: .blink, object: nil)
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	@objc private func handlePerformAmount() {
		checkEyes()
	}

	private func checkEyes() {
		if UserDefaults.standard.isHiddenAmount {
			amountLabel.text = Resource.Title.privateAmount + " " + Resource.Title.vnd
		} else {
			amountLabel.text = currentAmount.formatMoneyNumber() + " " + Resource.Title.vnd
		}
	}

	@IBAction func changeAccountBalance(_ sender: Any) {
		changeAmount?()
	}


}
