//
//  TransactionHistoryManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 13/04/2023.
//

import UIKit

class TransactionHistoryManager {
	var curentAmount: Double {
		return UserDefaults.standard.accountBalance
	}
	let months: [Date] = Date.getTwentyRecentMonths()
	var indexOfThisMonth: Int {
		return months.count - 2
	}
}
