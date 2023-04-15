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
		textField.delegate = self
		textField.becomeFirstResponder()
		textField.text = currentAmount.formatMoneyNumber()
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
			let result = self.createChangeAmountTransaction()
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

	private func createChangeAmountTransaction() -> Bool {
//		UserDefaults.standard.accountBalance = self.textField.text?.currency ?? 0
		return true
	}

}

//MARK: - Conform UITextFieldDelegate
extension PopUpInputController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.endEditing(true)
		return true
	}
}
