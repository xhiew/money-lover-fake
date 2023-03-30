//
//  LabelViewCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/03/2023.
//

import UIKit
import SnapKit

class LabelViewCell: UICollectionViewCell {

  @IBOutlet weak var mainLabel: UILabel!
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var stackHeightConstraint: NSLayoutConstraint!

  var categories: [Category]?

  override func awakeFromNib() {
    super.awakeFromNib()
    mainLabel.text = Resource.Title.Onboarding.mainTitlePage1
    addCategory()
  }

  func addCategory() {
    guard let categories = categories else { return }
    clearStackView()
    for category in categories {
      let view = OnBoardingCustomView()
      view.setupUI(image: category.image, title: category.title)
      stackView.addArrangedSubview(view)
      view.snp.makeConstraints { make in
        make.width.equalTo(stackView)
      }
    }
    stackHeightConstraint.constant = Demension.shared.heightForCategory * CGFloat(categories.count) + Demension.shared.stackSpacing * CGFloat(categories.count - 1)
  }

  func clearStackView() {
    stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
  }

}
