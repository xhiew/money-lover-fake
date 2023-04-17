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
	var reportTransactionsInThisMonth: [Transaction]?
	var reportTransactionsInThisWeek: [Transaction]?
	var reportTransactionsInLastMonth: [Transaction]?
	var reportTransactionsInLastWeek: [Transaction]?

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
		reportTransactionsInThisMonth = RealmManager.getAllExpenseTransactionsInMonth()
		reportTransactionsInThisWeek = RealmManager.getAllExpenseTransactionsInWeek()
		reportTransactionsInLastMonth = RealmManager.getAllExpenseTransactionsInMonth(date: Date().adding(.month, value: -1))
		reportTransactionsInLastWeek = RealmManager.getAllExpenseTransactionsInWeek(date: Date().adding(.weekOfMonth, value: -1))
	}

	func reloadHomeViewIfNeed() {
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
	
}
