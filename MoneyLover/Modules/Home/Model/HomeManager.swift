//
//  HomeManager.swift
//  MoneyLover
//
//  Created by xhieu21 on 27/03/2023.
//

import UIKit

class HomeManager {
  let homeItem: [HomeItem] = [.accBalance,
                              .myWallet,
                              .header(title: Resource.Title.Home.expenseReport),
                              .expenseReport,
                              .header(title: Resource.Title.Home.sales),
                              .promo,
                              .header(title: Resource.Title.Home.recentTransaction),
                              .recentTransaction,
                              .header(title: Resource.Title.Home.personalPlan),
                              .personalPlan
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
}
