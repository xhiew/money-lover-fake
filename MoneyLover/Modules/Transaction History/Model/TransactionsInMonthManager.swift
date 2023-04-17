//
//  TransactionsInMonthManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/04/2023.
//

import UIKit

protocol TransactionsInMonthManagerDelegate: AnyObject {
	func reloadView(_ transactionsInMonthManager: TransactionsInMonthManager)
}

class TransactionsInMonthManager {

	var month: Date? {
		didSet {
			transactionsInMonth = convertTo2DArray(transactions: getTransactionsInMonth(date: month))
		}
	}

	var transactionsInMonth: [[Transaction]?] = []
	private weak var delegate: TransactionsInMonthManagerDelegate?

	init() {

	}

	func attachView(view: TransactionsInMonthManagerDelegate) {
		delegate = view
	}

}

//MARK: - Methods
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

	func reloadThisMonthTransactions() {
		guard let month = month else { return }
		if month.isInCurrentMonth {
			transactionsInMonth = convertTo2DArray(transactions: getTransactionsInMonth(date: Date()))
			delegate?.reloadView(self)
		}
	}

	/// bởi vì khi nhận thông báo thì các màn đã nhảy vảo viewDidLoad (đã được swipe vào) thì sẽ nhận được thông báo nên phải so sánh month để chỉ update 1 màn trong số đó thay vì update tất cả
	func refetchTransactionIfNeed(newTransaction: Transaction) {
		guard let newMonth = newTransaction.date else { return }
		if month?.compareMonth(date: newMonth) ?? true {
			transactionsInMonth = convertTo2DArray(transactions: getTransactionsInMonth(date: newMonth))
			delegate?.reloadView(self)
		}
		/// không dùng else, nếu dùng else thì lại refresh tất cả các tháng
		/// vì self.month (tươn lai) chỉ hơn "Tháng này" 1 tháng nên nếu tạo giao dịch cách 2 tháng trở lên thì màn tương lai sẽ không được refresh nên so sánh với Date() 'hiện tại' để refresh màn tương lai
		if month ?? Date() > Date() {
			transactionsInMonth = convertTo2DArray(transactions: getTransactionsInMonth(date: month))
			delegate?.reloadView(self)
		}
	}
}
