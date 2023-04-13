//
//  TransactionHistoryManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 13/04/2023.
//

import UIKit

class TransactionHistoryManager {
	let monthNames = Date().getTwentyRecentMonths()
	var indexOfThisMonth: Int {
		return monthNames.count - 2
	}
	
}
