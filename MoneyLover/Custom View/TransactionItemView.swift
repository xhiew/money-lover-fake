//
//  TransactionItemView.swift
//  MoneyLover
//
//  Created by xhieu21 on 21/03/2023.
//

import UIKit

class TransactionItemView: UIView {

  @IBOutlet weak var imageItem: UIImageView!
  @IBOutlet weak var titleItem: UILabel!
  @IBOutlet weak var subTitle: UILabel!
  @IBOutlet weak var rightTitle: UILabel!


  override init(frame: CGRect) {
    super.init(frame: frame)
    configView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    configView()
  }

  private func configView() {
    let bundle = Bundle.init(for: TransactionItemView.self)
    if let viewToAdd = bundle.loadNibNamed(TransactionItemView.identifier, owner: self, options: nil), let contentView = viewToAdd.first as? UIView {
      addSubview(contentView)
      contentView.frame = self.bounds
      contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
  }

	func setupRecentTransactionUI(transaction: Transaction) {
		imageItem.image = UIImage(named: transaction.group?.image ?? "")
		titleItem.text = transaction.group?.name
		subTitle.text = transaction.date?.dateString(ofStyle: .full)
		rightTitle.text = transaction.amount?.formatMoneyNumber() ?? "0"
		if transaction.group?.groupType?.rawValue == nil {
			rightTitle.textColor = Theme.shared.primaryColor
		} else {
			rightTitle.textColor = (transaction.group?.isExpense ?? true)
			? Theme.shared.lightRed
			: Theme.shared.lightBlue
		}
  }

	func setupReportTransactionUI(transaction: Transaction) {

	}

}
