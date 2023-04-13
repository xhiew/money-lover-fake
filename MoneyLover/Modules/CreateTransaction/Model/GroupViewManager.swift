//
//  GroupViewManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 10/04/2023.
//

import UIKit


// nơi lấy group trong realm để hiện thị ra
class GroupViewManager {
	var groupItems: [[TransactionGroup]] = [[TransactionGroup(image: "ic_check_border", name: "Ăn uống", isExpense: true, groupType: 																				.monthlyExpenses), TransactionGroup(image: "ic_check_border", name: "Ăn uống", isExpense: true, groupType: 																				.monthlyExpenses), TransactionGroup(image: "ic_check_border", name: "Ăn uống", isExpense: true, groupType: 																				.monthlyExpenses), TransactionGroup(image: "ic_check_border", name: "Ăn uống", isExpense: true, groupType: 																				.monthlyExpenses), TransactionGroup(image: "ic_check_border", name: "Ăn uống", isExpense: true, groupType: 																				.monthlyExpenses), TransactionGroup(image: "ic_check_border", name: "Ăn uống", isExpense: true, groupType: 																				.monthlyExpenses), TransactionGroup(image: "ic_check_border", name: "Ăn uống", isExpense: true, groupType: 																				.monthlyExpenses)],
																					[TransactionGroup(image: "ic_check_border", name: "Bảo hiểm", isExpense: true, groupType: .essentialExpenses)],
																					[TransactionGroup(image: "ic_check_border", name: "Làm đẹp", isExpense: true, groupType: .entertainment)],
																					[TransactionGroup(image: "ic_check_border", name: "Lương", isExpense: false, groupType:
																																.revenue)]]

	init() {

	}

}
