//
//  TransactionGroup.swift
//  MoneyLover
//
//  Created by xhieu21 on 30/03/2023.
//

import RealmSwift
import UIKit

enum GroupType: String, PersistableEnum {
  case monthlyExpenses
  case essentialExpenses
  case entertainment
}

class TransactionGroup: Object {
  @Persisted(primaryKey: true) var id = 0
  @Persisted var image: String?
  @Persisted var name: String?
  @Persisted var isExpense: Bool?
  @Persisted var groupType: GroupType?

  convenience init(image: String?, name: String?, isExpense: Bool?, groupType: GroupType?) {
    self.init()
    self.image = image
    self.name = name
    self.isExpense = isExpense
    self.groupType = groupType
  }
}


