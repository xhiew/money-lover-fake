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

	func setupUI(imageString: String?, title: String?, note: String?, amount: String?) {
		itemImage.image = UIImage(named: imageString ?? "")
		itemTitle.text = title
		itemNote.text = note
		itemAmount.text = amount
	}
	
}
