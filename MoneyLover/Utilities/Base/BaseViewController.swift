//
//  BaseViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 30/03/2023.
//

import UIKit

class BaseViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
		addTapGesture()
  }

	private func addTapGesture() {
		view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture)))
	}

	@objc private func handleTapGesture() {
		view.endEditing(true)
	}

}
