//
//  PopUpInputController.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/04/2023.
//

import UIKit

class PopUpInputController: BaseViewController {

	@IBOutlet weak var textField: UITextField!

	var currentAmount: Double {
		return UserDefaults.standard.accountBalance
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		textField.text = currentAmount.formatMoneyNumber()
		textField.delegate = self
		textField.becomeFirstResponder()
	}

	@IBAction func cancelButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	@IBAction func valueChangedTextField(_ sender: Any) {
		if (textField.text?.count ?? 0) > 15 {
			textField.text?.removeLast()
		}
		textField.text = textField.text?.currency.formatMoneyNumber()
	}

	@IBAction func acceptButton(_ sender: Any) {
		let alert = UIAlertController(title: Resource.ActionTitle.confirmChangingAmount, message: nil, preferredStyle: .alert)
		let changeAccBalance = UIAlertAction(title: Resource.ActionTitle.agree, style: .default) { [weak self] _ in
			guard let self = self else { return }
			let result = self.createChangeAmountTransaction(newAmount: self.textField.text?.currency ?? 0)
			if result {
				NotificationCenter.default.post(name: .changedAmount, object: nil)
				self.dismiss(animated: true)
				Commons.shared.showToast(image: Resource.Image.systemSuccess?.withTintColor(Theme.shared.greenButtonColor, renderingMode: .alwaysOriginal), title: Resource.NotiTitle.successTitle, subtitle: Resource.NotiTitle.subTitleChangeAmount)
			}
		}
		alert.addAction(UIAlertAction(title: Resource.ActionTitle.cancel, style: .destructive, handler: nil))
		alert.addAction(changeAccBalance)
		present(alert, animated: true, completion: nil)
	}

	func createChangeAmountTransaction(newAmount: Double) -> Bool {
		let amountDiff = newAmount - currentAmount
		let group = RealmManager.getChangeAmountGroup()
		let newTransaction = Transaction(amount: amountDiff, group: group, note: Resource.ActionTitle.fineTuneAmount)
		let result = RealmManager.create(object: newTransaction)
		UserDefaults.standard.accountBalance = newAmount
		return result
	}

}

//MARK: - Conform UITextFieldDelegate
extension PopUpInputController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.endEditing(true)
		return true
	}
}
