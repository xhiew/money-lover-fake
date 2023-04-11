//
//  AmountViewCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 06/04/2023.
//

import UIKit

class AmountViewCell: BaseTableViewCell {

	@IBOutlet weak var inputTextField: UITextField!

	var getAmount: ((Double?) -> Void)?

	override func awakeFromNib() {
		super.awakeFromNib()
		inputTextField.becomeFirstResponder()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

	}
	
	@IBAction func inputAmountEditingChanged(_ sender: UITextField) {
		if inputTextField.text?.count ?? 0 > 15 {
			inputTextField.text?.removeLast()
		}
		inputTextField.text = inputTextField.text?.currency.formatMoneyNumber()
		getAmount?(inputTextField.text?.currency)
	}
}
