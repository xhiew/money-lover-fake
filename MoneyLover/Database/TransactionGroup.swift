//
//  TransactionGroup.swift
//  MoneyLover
//
//  Created by xhieu21 on 30/03/2023.
//

import RealmSwift
import UIKit

class TransactionGroup: Object {
	@Persisted var id: String = UUID().uuidString
  @Persisted var image: String?
  @Persisted var name: String?
  @Persisted var isExpense: Bool?
	@Persisted var canDelete: Bool?
  @Persisted var groupType: GroupType?

	convenience init(image: String?, name: String?, isExpense: Bool?, canDelete: Bool? = true, groupType: GroupType?) {
    self.init()
    self.image = image
    self.name = name
    self.isExpense = isExpense
		self.canDelete = canDelete
    self.groupType = groupType
  }
}

enum GroupType: String, PersistableEnum {
	case monthlyExpenses
	case essentialExpenses
	case entertainment
	case revenue

	func description() -> String? {
		switch self {
		case .monthlyExpenses:
			return Resource.Title.GroupTypeDescription.monthlyExpenses
		case .essentialExpenses:
			return Resource.Title.GroupTypeDescription.essentialExpenses
		default:
			return nil
		}
	}

	func toString() -> String {
		switch self {
		case .monthlyExpenses:
			return Resource.Title.GroupTypeTitle.monthlyExpenses
		case .essentialExpenses:
			return Resource.Title.GroupTypeTitle.essentialExpenses
		case .entertainment:
			return Resource.Title.GroupTypeTitle.entertainment
		case .revenue:
			return Resource.Title.GroupTypeTitle.revenue
		}
	}
}



