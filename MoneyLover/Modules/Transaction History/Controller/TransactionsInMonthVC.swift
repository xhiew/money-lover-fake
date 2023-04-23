//
//  TransactionsInMonthVC.swift
//  MoneyLover
//
//  Created by xhieu21 on 13/04/2023.
//

import UIKit
import PanModal

class TransactionsInMonthVC: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var iconLabel: UILabel!
	@IBOutlet weak var warningLabel: UILabel!
	@IBOutlet weak var constraintBot: NSLayoutConstraint!

	let transactionsInMonthManager = TransactionsInMonthManager()

	override func viewDidLoad() {
		super.viewDidLoad()
		configTableView()
		transactionsInMonthManager.attachView(view: self)
		constraintBot.constant = Demension.shared.heightOfTabBar * Demension.shared.heightScale
		NotificationCenter.default.addObserver(self, selector: #selector(updateTransactionInThisMonth), name: .changedAmount, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(updateViewWhenCreateNewTransaction(_:)), name: .createdNewTransaction, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(updateViewWhenCreateNewTransaction(_:)), name: .deletedTransaction, object: nil)
	}

	@objc private func updateTransactionInThisMonth() {
		transactionsInMonthManager.reloadThisMonthTransactions()
	}

	@objc private func updateViewWhenCreateNewTransaction(_ notification: Notification) {
		if let transaction = notification.object as? Transaction {
			transactionsInMonthManager.refetchTransactionIfNeed(newTransaction: transaction)
		}
	}

	private func configTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.register(DayHeaderCell.nib(), forHeaderFooterViewReuseIdentifier: DayHeaderCell.identifier)
		tableView.register(DayTransactionCell.nib(), forCellReuseIdentifier: DayTransactionCell.identifier)
	}

	private func showWarningIfNeed() {
		iconLabel.isHidden = !(transactionsInMonthManager.transactionsInMonth.count == 0)
		warningLabel.isHidden = !(transactionsInMonthManager.transactionsInMonth.count == 0)
	}

}

//MARK: - Conform UITableViewDelegate, UITableViewDataSource
extension TransactionsInMonthVC: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		showWarningIfNeed()
		return transactionsInMonthManager.transactionsInMonth.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return transactionsInMonthManager.transactionsInMonth[section]?.count ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DayTransactionCell.identifier, for: indexPath) as? DayTransactionCell
		guard let cell = cell else { return UITableViewCell() }
		cell.setupUI(transaction: transactionsInMonthManager.transactionsInMonth[indexPath.section]?[indexPath.row] ?? Transaction())
		return cell
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return Demension.shared.heightForDayHeader
	}

	func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
		if transactionsInMonthManager.transactionsInMonth[section]?.isEmpty ?? true {
			return 0.0
		}
		return Demension.shared.heightForDayHeader
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DayHeaderCell.identifier) as? DayHeaderCell
		guard let header = header else { return UIView() }

		guard let transactions = transactionsInMonthManager.transactionsInMonth[section] else { return nil }
		var totalAmount = 0.0
		for transaction in transactions {
			if transaction.group?.isExpense ?? false {
				totalAmount -= transaction.amount ?? 0.0
			} else {
				totalAmount += transaction.amount ?? 0.0
			}
		}
		let transaction = transactions.first
		header.setupUI(day: transaction?.date?.day ?? 0, fullDate: transaction?.date?.IgnoreDay(), totalAmount: totalAmount)
		return header
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let vc = DetailTransactionVC()
		let transaction =	transactionsInMonthManager.transactionsInMonth[indexPath.section]?[indexPath.row]
		vc.detailTransactionManager.transaction = transaction
		presentPanModal(vc)
	}

}

//MARK: - Conform TransactionsInMonthManagerDelegate
extension TransactionsInMonthVC: TransactionsInMonthManagerDelegate {
	func reloadView(_ transactionsInMonthManager: TransactionsInMonthManager) {
		tableView.reloadData()
	}

}
