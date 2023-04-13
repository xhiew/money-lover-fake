//
//  TransactionsInMonthVC.swift
//  MoneyLover
//
//  Created by xhieu21 on 13/04/2023.
//

import UIKit

class TransactionsInMonthVC: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	let transactionsInMonthManager = TransactionsInMonthManager()

	override func viewDidLoad() {
		super.viewDidLoad()
		configTableView()
	}

	private func configTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.contentInset = UIEdgeInsets(horizontal: 0.0, vertical: -(Demension.shared.sectionSpacing - 1))
		tableView.register(DayHeaderCell.nib(), forHeaderFooterViewReuseIdentifier: DayHeaderCell.identifier)
		tableView.register(DayTransactionCell.nib(), forCellReuseIdentifier: DayTransactionCell.identifier)
	}

}

//MARK: - Conform UITableViewDelegate, UITableViewDataSource
extension TransactionsInMonthVC: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		return transactionsInMonthManager.transactionsDummy.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return transactionsInMonthManager.transactionsDummy[section].count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DayTransactionCell.identifier, for: indexPath) as? DayTransactionCell
		guard let cell = cell else { return UITableViewCell() }
		return cell
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return Demension.shared.heightForDayHeader
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DayHeaderCell.identifier) as? DayHeaderCell
		guard let header = header else { return UIView() }
		return header
	}

}
