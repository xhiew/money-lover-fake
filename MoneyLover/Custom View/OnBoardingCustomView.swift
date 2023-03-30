//
//  OnBoardingCustomView.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/03/2023.
//

import UIKit

class OnBoardingCustomView: UIView {

  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var imageView: UIImageView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    configView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configView()
  }

  private func configView() {
    let bundle = Bundle.init(for: OnBoardingCustomView.self)
    if let viewToAdd = bundle.loadNibNamed(OnBoardingCustomView.identifier, owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
      addSubview(contentView)
      contentView.frame = self.bounds
      contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
  }

  func setupUI(image: UIImage?, title: String?) {
    label.text = title
    imageView.image = image
  }

}
