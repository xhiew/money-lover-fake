//
//  CreateGroupManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 11/04/2023.
//

import Foundation
import UIKit

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
