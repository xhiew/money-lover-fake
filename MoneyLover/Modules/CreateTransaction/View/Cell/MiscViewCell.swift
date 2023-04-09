//
//  MiscViewCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 06/04/2023.
//

import UIKit

protocol MiscViewDelegate: AnyObject {
	func didTapMiscView(_ cell: MiscViewCell, miscType: CreateViewItem)
}

class MiscViewCell: BaseTableViewCell {

	@IBOutlet weak var itemImage: UIImageView!
	@IBOutlet weak var itemTitle: UILabel!

	weak var delegate: MiscViewDelegate?
	var miscType: CreateViewItem?

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	func setupUI(image: UIImage?, title: String) {
		itemImage.image = image
		itemTitle.text = title
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

	@IBAction func didTapButton(_ sender: Any) {
		delegate?.didTapMiscView(self, miscType: miscType ?? .note)
	}


}
