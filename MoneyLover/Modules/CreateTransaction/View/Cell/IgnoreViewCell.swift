//
//  IgnoreViewCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 06/04/2023.
//

import UIKit
import AIFlatSwitch

class IgnoreViewCell: BaseTableViewCell {

	@IBOutlet weak var ignoreLabel: UILabel!
	@IBOutlet weak var flatSwitch: AIFlatSwitch!
	@IBOutlet weak var viewItem: UIView!

	var switchValueChange: ((Bool) -> Void)?
	var showPopUp: (() -> Void)?

	override func awakeFromNib() {
		super.awakeFromNib()
		viewItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animationSwitch)))
	}

	@objc func animationSwitch() {
		flatSwitch.setSelected(!flatSwitch.isSelected, animated: true)
		switchValueChange?(flatSwitch.isSelected)
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

		// Configure the view for the selected state
	}

	@IBAction func didTapInfoButton(_ sender: Any) {
		showPopUp?()
	}
}
