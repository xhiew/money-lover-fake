//
//  HomeManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 27/03/2023.
//

import UIKit

protocol HomeManagerDelegate: AnyObject {

}

class HomeManager {
  weak var delegate: HomeManagerDelegate?

  init() {

  }

  func attachView(delegate: HomeManagerDelegate) {
    self.delegate = delegate
  }

  let homeItem: [HomeItem] = [.accBalance,
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

  let expenses: [Transaction] = [Transaction(amount: 200000,
                                                group: TransactionGroup(image: "ic_home",
                                                                        name: "Sửa & trang trí nhà",
                                                                        isExpense: true,
                                                                        groupType: .essentialExpenses),
                                                note: "",
                                                date: Date()),
                                    Transaction(amount: 200000,
                                                group: TransactionGroup(image: "ic_home",
                                                                        name: "Học tập",
                                                                        isExpense: true,
                                                                        groupType: .essentialExpenses),
                                                note: "",
                                                date: Date()),
                                    Transaction(amount: 200000,
                                                group: TransactionGroup(image: "ic_home",
                                                                        name: "Tiền điện",
                                                                        isExpense: true,
                                                                        groupType: .essentialExpenses),
                                                note: "",
                                                date: Date()),
  ]

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
