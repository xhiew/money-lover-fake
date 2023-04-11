//
//  GroupItemViewCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 09/04/2023.
//

import UIKit

class GroupItemViewCell: BaseTableViewCell {
	@IBOutlet weak var itemImage: UIImageView!
	@IBOutlet weak var itemTitle: UILabel!
	@IBOutlet weak var checkmark: UIImageView!

	var didSelectGroupItem: ((IndexPath?) -> Void)?
	var itemIndexPath: IndexPath?

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	func setupUI(image: String?, title: String?) {
		itemImage.image = UIImage(named: image ?? "")
		itemTitle.text = title
	}

	func showCheckMark() {
		checkmark.isHidden = false
	}

	@IBAction func didTapOnItem(_ sender: Any) {
		didSelectGroupItem?(itemIndexPath)
	}

	override func prepareForReuse() {
		checkmark.isHidden = true
	}
}
