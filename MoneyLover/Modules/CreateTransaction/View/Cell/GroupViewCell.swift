//
//  GroupViewCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 06/04/2023.
//

import UIKit

protocol GroupViewDelegate: AnyObject {
	func selectGroup(_ cell: GroupViewCell, group: TransactionGroup?)
}

class GroupViewCell: BaseTableViewCell {
	@IBOutlet weak var groupImage: UIImageView!
	@IBOutlet weak var groupName: UILabel!

	weak var delegate: GroupViewDelegate?
	var group: TransactionGroup?

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

	func setupUI(imageName: String, title: String) {
		groupImage.image = UIImage(named: imageName)
		groupName.text = title
	}

	@IBAction func didTapSelectGroup(_ sender: Any) {
		delegate?.selectGroup(self, group: group)
	}
}
