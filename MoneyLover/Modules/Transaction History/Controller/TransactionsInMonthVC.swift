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

	}

	private func configTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.register(DayHeaderCell.nib(), forCellReuseIdentifier: DayHeaderCell.identifier)
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
		return UITableViewCell()
	}

}
