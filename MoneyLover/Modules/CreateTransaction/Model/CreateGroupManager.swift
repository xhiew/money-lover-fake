//
//  CreateGroupManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 11/04/2023.
//

import UIKit

protocol CreateGroupManagerDelegate: AnyObject {
	func handleSuccessCreateGroup(_ createGroupManager: CreateGroupManager)
	func handleFailedCreateGroup(_ createGroupManager: CreateGroupManager)
}

class CreateGroupManager {
	let newGroup = TransactionGroup()
	let segmentedItem: [SegmentedItem] = [.revenue, .expense]
	let groupIcons: [String] = ExistingData.shared.groupIcons
	let groupTypes: [GroupType] = ExistingData.shared.groupTypes
	weak var delegate: CreateGroupManagerDelegate?

	init() {
		setDefaultGroup()
	}

	func attachView(view: CreateGroupManagerDelegate) {
		delegate = view
	}

	private func setDefaultGroup() {
		newGroup.canDelete = true
	}

	func createNewGroup() {
		let result = RealmManager.create(object: newGroup)
		if result {
			delegate?.handleSuccessCreateGroup(self)
		} else {
			delegate?.handleFailedCreateGroup(self)
		}
	}

}

enum SegmentedItem {
	case revenue
	case expense
}
