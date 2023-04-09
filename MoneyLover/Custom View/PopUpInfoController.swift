//
//  PopUpInfoController.swift
//  MoneyLover
//
//  Created by xhieu21 on 07/04/2023.
//

import UIKit
import PanModal

class PopUpInfoController: UIViewController {

	@IBOutlet weak var mainTitle: UILabel!
	@IBOutlet weak var contentLabel: UILabel!

	var messageTitle = ""
	var messageContent = ""

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	private func setupUI() {
		mainTitle.text = messageTitle
		let attributedString = NSMutableAttributedString(string: messageContent)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.lineSpacing = 10
		attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
		contentLabel.attributedText = attributedString
		contentLabel.textAlignment = .center
	}

	@IBAction func closeButtonAction(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

}

extension PopUpInfoController: PanModalPresentable {
	var panScrollable: UIScrollView? {
		return nil
	}

	var showDragIndicator: Bool {
		return false
	}

	var longFormHeight: PanModalHeight {
		return .intrinsicHeight
	}

}
