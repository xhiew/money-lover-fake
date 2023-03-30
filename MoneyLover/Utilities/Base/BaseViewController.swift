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
    let tap = UITapGestureRecognizer(target: self, action: #selector(didTapView))
    view.addGestureRecognizer(tap)
  }

  @objc private func didTapView() {
      NotificationCenter.default.post(name: .tapOnView, object: nil)
  }

}
