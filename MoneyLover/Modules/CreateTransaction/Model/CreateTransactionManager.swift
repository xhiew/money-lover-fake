//
//  CreateTransactionManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 07/04/2023.
//

import UIKit

// nơi để tạo giao dịch mới

protocol CreateTransactionManagerDelegate: AnyObject {

}

class CreateTransactionManager {
	weak var delegate: CreateTransactionManagerDelegate?
	let createViewItem: [CreateViewItem] = [.amount, .group, .note, .date, .ignore]
	var isIgnoreReport = false
	let today = Date().dateString(ofStyle: .full)
	let newTransaction = Transaction()

}

enum CreateViewItem {
	case amount
	case group
	case note
	case date
	case ignore
}
