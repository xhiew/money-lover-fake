//
//  RecentTransactionCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 21/03/2023.
//

import UIKit

class RecentTransactionCell: BaseTableViewCell {

  @IBOutlet weak var stateLabel: UILabel!
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var heightConstraint: NSLayoutConstraint!

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func showItems(transactions: [Transaction]?) {
    guard let transactions = transactions else { return }
		if transactions.isEmpty {
			stateLabel.isHidden = false
			return
		} else {
			stateLabel.isHidden = true
		}
		clearStack()
    for transaction in transactions {
      let itemView = TransactionItemView()
			itemView.setupRecentTransactionUI(transaction: transaction)
      stackView.addArrangedSubview(itemView)
      itemView.snp.makeConstraints { make in
        make.width.equalTo(stackView)
      }
    }
    /// +32 để bù lại padding của stack với view (16 top, 16 bot)
    heightConstraint.constant = Demension.shared.heightForItemTransaction * CGFloat(transactions.count) + Demension.shared
      .stackSpacing * CGFloat(transactions.count - 1) + 32
  }

	private func clearStack() {
		stackView.arrangedSubviews.forEach({$0.removeFromSuperview()})
	}

}
