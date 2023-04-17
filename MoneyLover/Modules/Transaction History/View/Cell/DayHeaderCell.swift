//
//  DayHeaderCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/04/2023.
//

import UIKit

class DayHeaderCell: UITableViewHeaderFooterView {
	@IBOutlet weak var dayLabel: UILabel!
	@IBOutlet weak var fullDateLabel: UILabel!
	@IBOutlet weak var totalAmount: UILabel!

	func setupUI(day: Int, fullDate: String?, totalAmount: Double?) {
		dayLabel.text = String(describing: day)
		fullDateLabel.text = fullDate
		if (totalAmount ?? 0) > 0 {
			self.totalAmount.text = "+" + (totalAmount?.formatMoneyNumber() ?? "0")
		} else {
			self.totalAmount.text = totalAmount?.formatMoneyNumber()
		}
	}
}
