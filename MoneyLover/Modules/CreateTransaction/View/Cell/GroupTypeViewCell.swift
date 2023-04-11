//
//  GroupTypeViewCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 11/04/2023.
//

import UIKit

class GroupTypeViewCell: BaseTableViewCell {

	@IBOutlet weak var mainTitle: UILabel!
	@IBOutlet weak var subTitle: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	func setupUI(mainTitle: String?, subTitle: String?) {
		self.mainTitle.text = mainTitle ?? ""
		self.subTitle.text = subTitle ?? ""
	}

}
