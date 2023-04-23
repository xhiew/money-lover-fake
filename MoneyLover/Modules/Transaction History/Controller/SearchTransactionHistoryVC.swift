//
//  SearchTransactionHistoryVC.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/04/2023.
//

import UIKit

class SearchTransactionHistoryVC: UIViewController {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!

	let searchTransactionHistoryManager = SearchTransactionHistoryManager()
	var isSearching = false
	var recentIndexPath = IndexPath(row: 0, section: 0)

	override func viewDidLoad() {
		super.viewDidLoad()
		searchBar.delegate = self
		searchBar.becomeFirstResponder()
		configTableView()
		NotificationCenter.default.addObserver(self, selector: #selector(handleDeletedTransaction), name: .deletedTransaction, object: nil)
	}

	@objc func handleDeletedTransaction() {
		searchTransactionHistoryManager.filterTransaction[recentIndexPath.section]?.remove(at: recentIndexPath.row)
		tableView.deleteRows(at: [recentIndexPath], with: .fade)
	}

	@IBAction func dismissButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

	private func configTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.register(DayTransactionCell.nib(), forCellReuseIdentifier: DayTransactionCell.identifier)
		tableView.register(DayHeaderCell.nib(), forHeaderFooterViewReuseIdentifier: DayHeaderCell.identifier)
	}

}

//MARK: - Conform UITableViewDelegate, UITableViewDataSource
extension SearchTransactionHistoryVC:	UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		if isSearching {
			return searchTransactionHistoryManager.filterTransaction.count
		}
		return 0
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if isSearching {
			return searchTransactionHistoryManager.filterTransaction[section]?.count ?? 0
		}
		return 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DayTransactionCell.identifier, for: indexPath) as? DayTransactionCell
		guard let cell = cell else { return UITableViewCell() }
		cell.setupUI(transaction: searchTransactionHistoryManager.filterTransaction[indexPath.section]?[indexPath.row] ?? Transaction())
		return cell
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: DayHeaderCell.identifier) as? DayHeaderCell
		guard let header = header else { return UIView() }

		guard let transactions = searchTransactionHistoryManager.filterTransaction[section] else { return nil }
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

	func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
		if isSearching,
			 !(searchTransactionHistoryManager.filterTransaction[section]?.isEmpty ?? false) {
			return Demension.shared.heightForDayHeader
		}
		return 0.0
	}

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return Demension.shared.heightForDayHeader
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if isSearching {
			recentIndexPath = indexPath
			let vc = DetailTransactionVC()
			let transaction =	searchTransactionHistoryManager.filterTransaction[indexPath.section]?[indexPath.row]
			vc.detailTransactionManager.transaction = transaction
			presentPanModal(vc)
		}
	}
}

//MARK: - Conform UISearchBarDelegate
extension SearchTransactionHistoryVC: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		isSearching = !searchText.isEmpty

		if isSearching {
			searchTransactionHistoryManager.filterTransaction = searchTransactionHistoryManager.allTransaction.map({
				$0?.filter({
					$0.group?.name?.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces)) ?? false
				})
			})
			tableView.reloadData()
		} else {
			tableView.reloadData()
		}
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		view.endEditing(true)
	}
}
