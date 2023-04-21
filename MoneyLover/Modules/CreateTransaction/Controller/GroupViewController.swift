//
//  GroupViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 08/04/2023.
//

import UIKit
import SwiftUI

protocol GroupViewControllerDelegate: AnyObject {
	func didSelectGroupItem(_ sender: GroupViewController, indexPath: IndexPath?, group: TransactionGroup)
}

class GroupViewController: BaseViewController {

	@IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var notificationLabel: UILabel!

	weak var delegate: GroupViewControllerDelegate?
	let groupViewManager = GroupViewManager()
	var selectedGroupIndexPath: IndexPath?
	var filterGroup: [[TransactionGroup]?]?
	var isSearching = false

	override func viewDidLoad() {
		super.viewDidLoad()
		searchBar.delegate = self
		configTableView()
		tableView.scrollToRow(at: selectedGroupIndexPath ?? IndexPath(row: 0, section: 0), at: .middle, animated: true)
	}

	func configTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(GroupItemViewCell.nib(), forCellReuseIdentifier: GroupItemViewCell.identifier)
		tableView.register(HeaderGroupViewCell.nib(), forHeaderFooterViewReuseIdentifier: HeaderGroupViewCell.identifier)
	}

	@IBAction func backButtonAction(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}

	@IBAction func addButtonAction(_ sender: Any) {
		let createGroupVC = CreateGroupViewController()
		createGroupVC.sucessDeleteGroup = { [weak self] in
			self?.groupViewManager.updateData()
			self?.tableView.reloadData()
		}
		navigationController?.pushViewController(createGroupVC, animated: true)
	}

}

//MARK: - Conform UITableViewDataSource, UITableViewDelegate
extension GroupViewController: UITableViewDataSource, UITableViewDelegate {
	func numberOfSections(in tableView: UITableView) -> Int {
		if let filterGroup = filterGroup, isSearching {
			return filterGroup.count
		}
		return groupViewManager.groupItems.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let filterGroup = filterGroup, isSearching {
			return filterGroup[section]?.count ?? 0
		}
		return groupViewManager.groupItems[section]?.count  ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: GroupItemViewCell.identifier, for: indexPath) as? GroupItemViewCell

		guard let cell = cell else { return UITableViewCell() }

		cell.itemIndexPath = indexPath
		if cell.itemIndexPath == selectedGroupIndexPath {
			cell.showCheckMark()
		}

		if let filterGroup = filterGroup, isSearching {
			cell.setupUI(image: filterGroup[indexPath.section]?[indexPath.row].image, title: filterGroup[indexPath.section]?[indexPath.row].name)
		} else {
			cell.setupUI(image: groupViewManager.groupItems[indexPath.section]?[indexPath.row].image, title: groupViewManager.groupItems[indexPath.section]?[indexPath.row].name)
		}
		cell.didSelectGroupItem = { [weak self] indexPath in
			guard let self = self, let indexPath = indexPath else { return }

			if let filterGroup = self.filterGroup, self.isSearching {
				let selectedGroup = filterGroup[indexPath.section]?[indexPath.row]
				self.delegate?.didSelectGroupItem(self, indexPath: indexPath, group: selectedGroup ?? TransactionGroup())
			} else {
				let selectedGroup = self.groupViewManager.groupItems[indexPath.section]?[indexPath.row]
				self.delegate?.didSelectGroupItem(self, indexPath: indexPath, group: selectedGroup ?? TransactionGroup())
			}

			self.navigationController?.popViewController(animated: true)
		}
		return cell
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderGroupViewCell.identifier) as? HeaderGroupViewCell
		guard let header = header else { return UIView() }

		if let filterGroup = filterGroup, isSearching {
			if filterGroup[section]?.isEmpty ?? true {
				return nil
			} else {
				header.headerTitle.text = filterGroup[section]?[0].groupType?.toString()
			}
		} else {
			if groupViewManager.groupItems[section]?.isEmpty ?? true {
				return nil
			} else {
				header.headerTitle.text = groupViewManager.groupItems[section]?[0].groupType?.toString()
			}
		}
		return header
	}

	func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
		if let filterGroup = filterGroup, isSearching {
			if filterGroup[section]?.isEmpty ?? true {
				return 0.0
			}
		}
		return tableView.estimatedSectionHeaderHeight
	}

	func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let deleteItem = UIContextualAction(style: .destructive, title: Resource.ActionTitle.delete) { [weak self] action, view, completion in
			guard let self = self else { return }

			let deletedGroup: TransactionGroup?
			if self.isSearching {
				deletedGroup = self.filterGroup?[indexPath.section]?[indexPath.row]
			} else {
				deletedGroup = self.groupViewManager.groupItems[indexPath.section]?[indexPath.row]
			}
			let result = self.groupViewManager.handleDeleteTransactionGroup(group: deletedGroup ?? TransactionGroup())
			if result {
				if self.isSearching {
					self.filterGroup?[indexPath.section]?.remove(at: indexPath.row)
					self.tableView.deleteRows(at: [indexPath], with: .fade)
					self.groupViewManager.updateData()
					self.tableView.reloadData()
				} else {
					self.groupViewManager.groupItems[indexPath.section]?.remove(at: indexPath.row)
					self.tableView.deleteRows(at: [indexPath], with: .fade)
				}
				Commons.shared.showToast(image: Resource.Image.systemSuccess?.withTintColor(Theme.shared.greenButtonColor, renderingMode: .alwaysOriginal), title: Resource.NotiTitle.successTitle, subtitle: Resource.NotiTitle.successDeleted)
			} else {
				Commons.shared.showToast(image: Resource.Image.systemError?.withTintColor(Theme.shared.warningColor, renderingMode: .alwaysOriginal), title: Resource.NotiTitle.warningTitle, subtitle: Resource.NotiTitle.defaultGroupSubtitle)
			}
			completion(true)
		}
		let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteItem])
		return swipeConfiguration
	}

}

//MARK: - Conform UISearchBarDelegate
extension GroupViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		if searchText == "" {
			notificationLabel.isHidden = true
			isSearching = false
			tableView.reloadData()
		} else {
			isSearching = true
			filterGroup = groupViewManager.groupItems.map({
				$0?.filter({
					$0.name?.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces)) ?? false
				})
			})
			notificationLabel.isHidden = !(filterGroup?.allSatisfy({
				$0?.isEmpty ?? true
			}) ?? true)
			tableView.reloadData()
		}
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		searchBar.endEditing(true)
	}
}
