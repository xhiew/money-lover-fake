//
//  HeaderCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 21/03/2023.
//

import UIKit

class HeaderCell: BaseTableViewCell {

  @IBOutlet weak var titleLabel: UILabel!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func setTitle(title: String?) {
    titleLabel.text = title
  }

}
