//
//  Transaction.swift
//  MoneyLover
//
//  Created by xhieu21 on 30/03/2023.
//

import RealmSwift

class Transaction: Object {
	@Persisted var id: String = UUID().uuidString
  @Persisted var amount: Double?
  @Persisted var group: TransactionGroup?
  @Persisted var note: String?
  @Persisted var date: Date?
	@Persisted var isIgnore: Bool?

	convenience init(amount: Double?, group: TransactionGroup?, note: String?, date: Date? = Date(), isIgnore: Bool? = false) {
    self.init()
    self.amount = amount
    self.group = group
    self.note = note
    self.date = date
		self.isIgnore = isIgnore
  }

}
