//
//  DateViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 08/04/2023.
//

import UIKit
import PanModal

class DateViewController: UIViewController {

	@IBOutlet weak var datePicker: UIDatePicker!
	var sendDate: ((Date) -> Void)?
	var setDate = Date()

	override func viewDidLoad() {
		super.viewDidLoad()
		datePicker.date = setDate
	}
}

extension DateViewController: PanModalPresentable {
	var panScrollable: UIScrollView? {
		return nil
	}

	var longFormHeight: PanModalHeight {
		return .intrinsicHeight
	}

	func panModalWillDismiss() {
		sendDate?(datePicker.date)
	}
}
