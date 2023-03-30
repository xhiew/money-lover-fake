//
//  PromotionCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 21/03/2023.
//

import UIKit

class PromotionCell: BaseTableViewCell {

  @IBOutlet weak var upgradeButton: UIButton!
  @IBOutlet weak var titlePromotion: UILabel!
  @IBOutlet weak var discountLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  override func configUI() {
    super.configUI()
    upgradeButton.roundCorners(corners: .allCorners, radius: 10.0)
    upgradeButton.layer.borderWidth = 1
    upgradeButton.layer.borderColor = UIColor.systemYellow.cgColor
  }

  func setupUI(title: String?, discount: String?) {
    titlePromotion.text = title
    if let discount = discount {
      discountLabel.text = "-" + discount + "%"
    }

  }

  @IBAction func upgradeButtonAction(_ sender: UIButton) {
    Commons.shared.animateButton(viewToAnimate: sender)
  }

}
