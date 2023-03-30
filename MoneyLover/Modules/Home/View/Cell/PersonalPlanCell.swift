//
//  PersonalPlanCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 21/03/2023.
//

import UIKit

class PersonalPlanCell: BaseTableViewCell {

  @IBOutlet weak var notiButton: UIButton!

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
    notiButton.roundCorners()
    notiButton.layer.borderColor = Theme.shared.primaryColor.cgColor
    notiButton.layer.borderWidth = 2
    notiButton.backgroundColor = Theme.shared.primaryColor
    notiButton.setTitleColor(.white, for: .normal)
    notiButton.setTitle(Resource.Title.Home.notiButton1, for: .normal)
  }

  @IBAction func notiButtonAction(_ sender: UIButton) {
    Commons.shared.animateButton(viewToAnimate: sender)
    notiButton.backgroundColor = .white
    notiButton.setTitleColor(Theme.shared.primaryColor, for: .normal)
    notiButton.setTitle(Resource.Title.Home.notiButton2, for: .normal)
    sender.isUserInteractionEnabled = false
  }

}
