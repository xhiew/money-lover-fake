//
//  DetailTransactionVC.swift
//  MoneyLover
//
//  Created by xhieu21 on 21/04/2023.
//

import UIKit
import PanModal

class DetailTransactionVC: UIViewController {

	@IBOutlet weak var ignoreTransactionView: UIView!
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var noteLabel: UILabel!
	@IBOutlet weak var amountLabel: UILabel!

	var transaction: Transaction?
	var deleteAction: (() -> Void)?

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI(transaction: transaction)
	}

	@IBAction func deleteItemAction(_ sender: Any) {
		let alert = UIAlertController(title: Resource.ActionTitle.deleteTransaction, message: nil, preferredStyle: .actionSheet)
		let deleteAction = UIAlertAction(title: Resource.ActionTitle.delete, style: .destructive) { [weak self] _ in
			self?.deleteAction?()
			self?.dismiss(animated: true, completion: nil)
		}
		alert.addAction(deleteAction)
		alert.addAction(UIAlertAction(title: Resource.ActionTitle.cancel, style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}

	@IBAction func editItemAction(_ sender: Any) {
	}

	private func setupUI(transaction: Transaction?) {
		guard let transaction = transaction else { return }
		if transaction.isIgnore ?? false {
			ignoreTransactionView.isHidden = false
		}
		dateLabel.text = transaction.date?.dateString(ofStyle: .full)
		imageView.image = UIImage(named: transaction.group?.image ?? "")
		nameLabel.text = transaction.group?.name
		noteLabel.text = transaction.note
		amountLabel.text = transaction.amount?.formatMoneyNumber()
		if transaction.group?.groupType == nil {
			amountLabel.textColor = Theme.shared.primaryColor
		} else {
			amountLabel.textColor = (transaction.group?.isExpense) ?? true
			? Theme.shared.lightRed
			: Theme.shared.lightBlue
		}
	}

}

//MARK: - Conform PanModalPresentable
extension DetailTransactionVC: PanModalPresentable {
	var panScrollable: UIScrollView? {
		return nil
	}

	var shortFormHeight: PanModalHeight {
		return .intrinsicHeight
	}

}
