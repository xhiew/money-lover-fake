//
//  NoteViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 08/04/2023.
//

import UIKit

class NoteViewController: UIViewController {

	@IBOutlet weak var noteTextView: UITextView!

	var currentText = ""
	var getNote: ((String?) -> Void)?

	override func viewDidLoad() {
		super.viewDidLoad()
		noteTextView.text = currentText
		noteTextView.becomeFirstResponder()
	}

	@IBAction func backAction(_ sender: Any) {
		getNote?(noteTextView.text)
		navigationController?.popViewController(animated: true)
	}

}
