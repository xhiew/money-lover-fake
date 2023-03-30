//
//  TransactionGroup.swift
//  MoneyLover
//
//  Created by xhieu21 on 30/03/2023.
//

import RealmSwift
import UIKit

class TransactionGroup: Object {
  @Persisted var id: String
  @Persisted var image: String?
  @Persisted var name: String?
  @Persisted var isExpense: Bool?
  @Persisted var groupType: String?

  init(image: String?, name: String?, isExpense: Bool?, groupType: String?) {
    self.id = UUID().uuidString
    self.image = image
    self.name = name
    self.isExpense = isExpense
    self.groupType = groupType
  }
}


