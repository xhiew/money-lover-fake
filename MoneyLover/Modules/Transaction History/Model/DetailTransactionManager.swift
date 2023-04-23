//
//  DetailTransactionManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 23/04/2023.
//

import Foundation

protocol DetailTransactionManagerDelegate: AnyObject {
	func handleSuccessDeleteTransaction(_ detailTransactionManager: DetailTransactionManager, deletedTransaction: Transaction)
}

class DetailTransactionManager {

	weak var delegate: DetailTransactionManagerDelegate?
	var transaction: Transaction?
	var transactionClone = Transaction()

	private func coppyTransaction() {
		transactionClone.id = transaction?.id ?? ""
		transactionClone.group = transaction?.group
		transactionClone.amount = transaction?.amount
		transactionClone.note = transaction?.note
		transactionClone.date = transaction?.date
		transactionClone.isIgnore = transaction?.isIgnore
	}

	func handleDeleteTransaction() {
		guard let transaction = transaction else { return }
		coppyTransaction()
		let amount =	transaction.amount ?? 0.0
		(transaction.group?.isExpense ?? true)
		? (UserDefaults.standard.accountBalance += amount)
		:	(UserDefaults.standard.accountBalance -= amount)
		let result = RealmManager.delete(object: transaction)
		if result {
			delegate?.handleSuccessDeleteTransaction(self, deletedTransaction: transactionClone)
		}
	}

}
