//
//  TransactionsInMonthManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/04/2023.
//

import UIKit
class TransactionsInMonthManager {
	var month: Date? {
		didSet {
			transactionsInMonth = convertTo2DArray(transactions: getTransactionsInMonth(date: month))
		}
	}
	var transactionsInMonth: [[Transaction]?] = []
	init() {
	}

}

//MARK: - Support
extension TransactionsInMonthManager {
	private func getTransactionsInMonth(date: Date?) -> [Transaction]? {
		if date ?? Date() > Date() {
			return RealmManager.getAllTransactionInFuture()
		}
		return RealmManager.getAllTransactionsInMonth(date: date ?? Date())
	}

	private func convertTo2DArray(transactions: [Transaction]?) -> [[Transaction]?] {
		guard let transactions = transactions else { return [] }
		var result: [[Transaction]?] = []
		var subArray: [Transaction]? = []
		var firstTransaction: Transaction = transactions[0]
		for transaction in transactions {
			if transaction.date?.day == firstTransaction.date?.day {
				subArray?.append(transaction)
			} else {
				result.append(subArray)
				subArray = [transaction]
				firstTransaction = transaction
			}
		}
		result.append(subArray)
		return result
	}
}
