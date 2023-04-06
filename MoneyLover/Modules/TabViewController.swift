//
//  TabViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 17/03/2023.
//

import UIKit
import PTCardTabBar

class TabViewController: UITabBarController {

  //MARK: - LifeCycle
  override func viewDidLoad() {

    let overview = HomeViewController()
    overview.tabBarItem = UITabBarItem(title: Resource.Title.TabBarTitle.home, image: Resource.Image.TabBarIcon.homeItemImg, tag: 1)

    let createTransaction = CreateTransactionController()
    createTransaction.tabBarItem = UITabBarItem(title: Resource.Title.TabBarTitle.create, image: Resource.Image.TabBarIcon.addImg, tag: 2)

    let transactionHistory = TransactionHistoryController()
    transactionHistory.tabBarItem = UITabBarItem(title: Resource.Title.TabBarTitle.history, image: Resource.Image.TabBarIcon.walletImg, tag: 3)

    self.viewControllers = [overview, createTransaction, transactionHistory]
    super.viewDidLoad()
    self.delegate = self
    configTabBar()
  }

  //MARK: - Methods
  func configTabBar() {
    tabBar.tintColor = Theme.shared.primaryColor
  }
}

extension TabViewController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
    if viewController is CreateTransactionController {
      let navVC = UINavigationController(rootViewController: CreateTransactionController())
      present(navVC, animated: true, completion: nil)
      return false
    }
    return true
  }
}
