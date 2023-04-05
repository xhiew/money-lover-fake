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

  override func awakeFromNib() {
    super.awakeFromNib()
    mainLabel.text = Resource.Title.Onboarding.mainTitlePage1
  }

  func addCategory(categories: [Category]?) {
    guard let categories = categories else { return }
    guard stackView.arrangedSubviews.isEmpty else { return }
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
  
}
