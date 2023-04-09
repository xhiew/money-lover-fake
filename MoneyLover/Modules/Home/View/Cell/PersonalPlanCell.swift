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
		handlePerformButton()
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
  }

  @IBAction func notiButtonAction(_ sender: UIButton) {
    Commons.shared.animateButton(viewToAnimate: sender)
		UserDefaults.standard.isSubscribed = true
		disableButton()
  }

	private func disableButton() {
		notiButton.backgroundColor = .white
		notiButton.setTitleColor(Theme.shared.primaryColor, for: .normal)
		notiButton.setTitle(Resource.Title.Home.notiButton2, for: .normal)
		notiButton.isUserInteractionEnabled = false
	}

	private func enableButton() {
		notiButton.backgroundColor = Theme.shared.primaryColor
		notiButton.setTitleColor(.white, for: .normal)
		notiButton.setTitle(Resource.Title.Home.notiButton1, for: .normal)
	}

	private func handlePerformButton() {
		if UserDefaults.standard.isSubscribed {
			UserDefaults.standard.isSubscribed = true
			disableButton()
		} else {
			enableButton()
		}
	}

}
