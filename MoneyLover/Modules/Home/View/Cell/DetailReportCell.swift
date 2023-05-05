//
//  DetailReportCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 04/05/2023.
//

import UIKit

class DetailReportCell: BaseTableViewCell {

	@IBOutlet weak var iconView: UIImageView!
	@IBOutlet weak var rightLabel: UILabel!
	@IBOutlet weak var leftLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	func setupView(imageName: String?, rightLabel: String?, leftLabel: Double?) {
		iconView.image = UIImage(named: imageName ?? "")
		self.rightLabel.text = rightLabel
		self.leftLabel.text = (leftLabel?.formatMoneyNumber() ?? "0") + " " + Resource.Title.vnd
	}

}
