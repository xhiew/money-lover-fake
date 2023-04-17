//
//  DayTransactionCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 13/04/2023.
//

import UIKit

class DayTransactionCell: BaseTableViewCell {
	
	@IBOutlet weak var itemImage: UIImageView!
	@IBOutlet weak var itemTitle: UILabel!
	@IBOutlet weak var itemNote: UILabel!
	@IBOutlet weak var itemAmount: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	func setupUI(transaction: Transaction) {
		guard let group = transaction.group else { return }
		if group.id == Resource.Title.idChangeAmount {
			itemAmount.textColor = Theme.shared.primaryColor
		} else {
			itemAmount.textColor = (group.isExpense ?? false)
			? Theme.shared.lightRed
			: Theme.shared.lightBlue
		}
		itemImage.image = UIImage(named: group.image ?? "")
		itemTitle.text = group.name
		itemNote.text = transaction.note
		itemAmount.text = transaction.amount?.formatMoneyNumber()
	}
	
}
