//
//  TransactionsInMonthManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/04/2023.
//

import UIKit

class TransactionsInMonthManager {
	let transactionsDummy = [
		[
		Transaction(amount: 123456,
								group: TransactionGroup(image: "ic_home", name: "Sửa nhà", isExpense: true, groupType: .essentialExpenses),
								note: nil),
		Transaction(amount: 123456,
								group: TransactionGroup(image: "ic_home", name: "Sửa nhà", isExpense: true, groupType: .essentialExpenses),
								note: nil)
		],
		[
			Transaction(amount: 456789,
									group: TransactionGroup(image: "ic_home", name: "Xây nhà", isExpense: true, groupType: .essentialExpenses),
									note: nil, date: Date().adding(.day, value: -1))
		]
	]
}
