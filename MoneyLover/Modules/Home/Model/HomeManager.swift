//
//  HomeManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 27/03/2023.
//

import UIKit

protocol HomeManagerDelegate: AnyObject {
	func reloadData(_ homeManager: HomeManager)
}

enum HomeItem {
	case accBalance
	case myWallet
	case header(title: String)
	case promo
	case personalPlan
	case expenseReport
	case recentTransaction
	case theEnd
}

class HomeManager {

	var currentAmount: Double {
		return UserDefaults.standard.accountBalance
	}

	private weak var delegate: HomeManagerDelegate?

	let homeItem: [HomeItem] =
	[
		.accBalance,
		.myWallet,
		.header(title: Resource.Title.Home.expenseReport),
		.expenseReport,
		.header(title: Resource.Title.Home.sales),
		.promo,
		.header(title: Resource.Title.Home.recentTransaction),
		.recentTransaction,
		.header(title: Resource.Title.Home.personalPlan),
		.personalPlan,
		.theEnd
	]

	var recentTransactions: [Transaction]?

	var reportTransactionsInThisMonth: [Transaction]? {
		didSet {
			let result =	mergeDuplicateTransactionName(transactions: reportTransactionsInThisMonth)
			if !result.isEmpty {
				totalThisMonthExpenses = 0.0
				result.forEach({
					totalThisMonthExpenses += $0.amount ?? 0.0
				})
			} else {
				totalThisMonthExpenses = 0.0
			}
			maxMonthlyExpenses = Array(result)
		}
	}

	var reportTransactionsInThisWeek: [Transaction]? {
		didSet {
			let result =	mergeDuplicateTransactionName(transactions: reportTransactionsInThisWeek)
			if !result.isEmpty {
				totalThisWeekExpenses = 0.0
				result.forEach({
					totalThisWeekExpenses += $0.amount ?? 0.0
				})
			} else {
				totalThisWeekExpenses = 0.0
			}
			maxWeeklyExpenses = Array(result)
		}
	}

	var reportTransactionsInLastMonth: [Transaction]? {
		didSet {
			if !(reportTransactionsInLastMonth?.isEmpty ?? true) {
				totalLastMonthExpenses = 0.0
				reportTransactionsInLastMonth?.forEach({
					totalLastMonthExpenses += $0.amount ?? 0.0
				})
			} else {
				totalLastMonthExpenses = 0.0
			}
		}
	}

	var reportTransactionsInLastWeek: [Transaction]? {
		didSet {
			if !(reportTransactionsInLastWeek?.isEmpty ?? true) {
				totalLastWeekExpenses = 0.0
				reportTransactionsInLastWeek?.forEach({
					totalLastWeekExpenses += $0.amount ?? 0.0
				})
			} else {
				totalLastWeekExpenses = 0.0
			}
		}
	}

	var maxMonthlyExpenses: [Transaction]?
	var maxWeeklyExpenses: [Transaction]?
	var totalThisMonthExpenses = 0.0
	var totalThisWeekExpenses = 0.0
	var totalLastMonthExpenses = 0.0
	var totalLastWeekExpenses = 0.0


	init() {
		fetchRecentTransactions()
		fetchReportTransactions()
	}

	func attachView(delegate: HomeManagerDelegate) {
		self.delegate = delegate
	}

	private func fetchRecentTransactions() {
		recentTransactions = RealmManager.getThreeRecentTransaction()
	}

	private func fetchReportTransactions() {
		reportTransactionsInThisMonth = RealmManager.getAllExpenseTransactionsInThisMonth()
		reportTransactionsInThisWeek = RealmManager.getAllExpenseTransactionsInThisWeek()
		reportTransactionsInLastMonth = RealmManager.getAllExpenseTransactionsInLastMonth()
		reportTransactionsInLastWeek = RealmManager.getAllExpenseTransactionsInLastWeek()
	}

	func reloadRecentViewAndWallet() {
		fetchRecentTransactions()
		delegate?.reloadData(self)
	}

	func reloadHomeViewWhenCreatedNewTransaction(newTransaction: Transaction) {
		if !(newTransaction.isIgnore ?? false) {
			fetchReportTransactions()
		}
		fetchRecentTransactions()
		delegate?.reloadData(self)
	}

	func reloadHomeView() {
		fetchRecentTransactions()
		fetchReportTransactions()
		delegate?.reloadData(self)
	}

	private func mergeDuplicateTransactionName(transactions: [Transaction]?) -> [Transaction] {
		guard let transactions = transactions else { return [] }
		var result: [Transaction] = []
		var tempTransaction = Transaction(amount: 0.0, group: transactions[0].group, note: transactions[0].note, date: transactions[0].date, isIgnore: transactions[0].isIgnore)
		for transaction in transactions {
			if transaction.group?.name == tempTransaction.group?.name, transaction.group?.image == transaction.group?.image {
				tempTransaction.amount! += transaction.amount ?? 0.0
			} else {
				result.append(tempTransaction)
				tempTransaction = Transaction(amount: transaction.amount, group: transaction.group, note: transaction.note, date: transaction.date, isIgnore: transaction.isIgnore)
			}
		}
		result.append(tempTransaction)
		result.sort(by: {
			($0.amount ?? 0.0) > ($1.amount ?? 0.0)
		})
		return result
	}

}
