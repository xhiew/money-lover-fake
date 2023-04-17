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
	weak var delegate: HomeManagerDelegate?
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

	init() {
	}

	func attachView(delegate: HomeManagerDelegate) {
		self.delegate = delegate
	}

	func reloadData() {
		delegate?.reloadData(self)
	}
	
}
