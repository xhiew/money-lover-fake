//
//  BaseTableViewCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 27/03/2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    configUI()
  }

  func configUI() {
    selectionStyle = .none
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
}
