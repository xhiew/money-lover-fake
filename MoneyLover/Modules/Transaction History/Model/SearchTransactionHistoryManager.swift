//
//  SearchTransactionHistoryManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 23/04/2023.
//

import UIKit

protocol SearchTransactionHistoryManagerDelegate {
	func handleSuccessDeleteTransaction(_ searchTransactionHistoryManager: SearchTransactionHistoryManager)
	func handleFailedDeleteTransaction(_ searchTransactionHistoryManager: SearchTransactionHistoryManager)
}

class SearchTransactionHistoryManager {
	var filterTransaction: [[Transaction]?] = []
	var allTransaction: [[Transaction]?] = []

	init() {
		allTransaction = convertTo2D(transactions: getAllTransaction())
	}

	private func getAllTransaction() -> [Transaction]? {
		return RealmManager.getAllTransactionAndSort()
	}

	private func convertTo2D(transactions: [Transaction]?) -> [[Transaction]?] {
		guard let transactions = transactions else { return [] }
		var result: [[Transaction]?] = []
		var subArray: [Transaction]? = []
		var firstTransaction: Transaction = transactions[0]
		for transaction in transactions {
			if transaction.date?.day == firstTransaction.date?.day,
				 transaction.date?.compareMonth(date: firstTransaction.date ?? Date()) ?? false {
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
