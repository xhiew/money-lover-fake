//
//  CreateGroupManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 11/04/2023.
//

import UIKit

// nơi để tạo mới 1 group

class CreateGroupManager {
	let newGroup = TransactionGroup()
	let segmentedItem: [SegmentedItem] = [.revenue, .expense]
	let groupIcons: [String] = ExistingData.shared.groupIcons
	let groupTypes: [GroupType] = ExistingData.shared.groupTypes

	init() {

	}

}

enum SegmentedItem {
	case revenue
	case expense
}
