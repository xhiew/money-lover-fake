//
//  GroupViewManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 10/04/2023.
//

import UIKit

class GroupViewManager {
	var groupItems: [[TransactionGroup]?] = []
	
	init() {
		fetchTransactionGroups()
	}

}

//MARK: - Methods
extension GroupViewManager {
	private func getAllGroup() -> [TransactionGroup] {
		let result: [TransactionGroup] = RealmManager.getAllGroupsAndSort()
		return result
	}

	private func convertTo2DArray(groups: [TransactionGroup]) -> [[TransactionGroup]?] {
		var result: [[TransactionGroup]?] = []
		var subArray: [TransactionGroup] = []
		var firstGroup: TransactionGroup = groups[0]
		for group in groups {
			if group.groupType == firstGroup.groupType {
				subArray.append(group)
			} else {
				result.append(subArray)
				subArray = [group]
				firstGroup = group
			}
		}
		result.append(subArray)
		return result
	}

	private func fetchTransactionGroups() {
		groupItems = convertTo2DArray(groups: getAllGroup())
	}

	func handleDeleteTransactionGroup(group: TransactionGroup) -> Bool {
		guard (group.canDelete ?? false) else { return false}
		/// nếu đã có giao dịch sử dụng group này thì group sẽ trở thành group mặc định
		let isExist = RealmManager.getAllTransactionWithGroup(group: group)
		if isExist {
			return false
		}
		let result = RealmManager.delete(object: group)
		return result
	}

	func updateData() {
		fetchTransactionGroups()
	}
}
