//
//  GroupIconViewCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 11/04/2023.
//

import UIKit

class GroupIconViewCell: UICollectionViewCell {

	@IBOutlet weak var groupIcon: UIImageView!

	override func awakeFromNib() {
		super.awakeFromNib()
	}

	func setImage(imageString: String?) {
		groupIcon.image = UIImage(named: imageString ?? "")
	}
}
