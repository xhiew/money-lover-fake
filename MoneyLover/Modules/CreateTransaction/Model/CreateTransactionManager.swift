//
//  CreateTransactionManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 07/04/2023.
//

import UIKit

enum CreateViewItem {
	case amount
	case group
	case note
	case date
	case ignore
}

protocol CreateTransactionManagerDelegate: AnyObject {
	func handleSuccessCreateTransaction(_ createTransactionManager: CreateTransactionManager, newTransaction: Transaction)
}

extension CreateTransactionManagerDelegate {
	func	handleFailedCreateTransaction(_ createTransactionManager: CreateTransactionManager) {}
}

class CreateTransactionManager {
	weak var delegate: CreateTransactionManagerDelegate?
	let createViewItem: [CreateViewItem] = [.amount, .group, .note, .date, .ignore]
	let today = Date().dateString(ofStyle: .full)
	let newTransaction = Transaction()

	init() {
		setDefaultDate()
	}

	private func setDefaultDate() {
		newTransaction.date = Date()
	}
	
}

//MARK: - Methods
extension CreateTransactionManager {
	func createNewTransaction() {
		let result = RealmManager.create(object: newTransaction)
		if result {
			delegate?.handleSuccessCreateTransaction(self, newTransaction: newTransaction)
		} else {
			delegate?.handleFailedCreateTransaction(self)
		}
	}

}

