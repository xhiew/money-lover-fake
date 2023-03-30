//
//  Transaction.swift
//  MoneyLover
//
//  Created by xhieu21 on 30/03/2023.
//

import RealmSwift

class Transaction: Object {

  @Persisted var id: String
  @Persisted var amount: Double?
  @Persisted var group: TransactionGroup?
  @Persisted var note: String?
  @Persisted var date: Date?

  init(amount: Double?, group: TransactionGroup?, note: String?, date: Date?) {
    id = UUID().uuidString
    self.amount = amount
    self.group = group
    self.note = note
    self.date = date
  }

}
