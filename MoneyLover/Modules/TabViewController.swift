//
//  TabViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 17/03/2023.
//

import UIKit
import PTCardTabBar

class TabViewController: PTCardTabBarController {

  //MARK: - Properties
  var timer: Timer?
  var isHidden = false
  let timeAutoHidden = 4.0

  //MARK: - LifeCycle
  override func viewDidLoad() {

    let overview = HomeViewController()
    overview.tabBarItem = UITabBarItem(title: nil, image: Resource.Image.TabBarIcon.homeItemImg, tag: 1)

    let createTransaction = BaseViewController()
    createTransaction.tabBarItem = UITabBarItem(title: nil, image: Resource.Image.TabBarIcon.addImg, tag: 2)

    let transactionHistory = BaseViewController()
    transactionHistory.tabBarItem = UITabBarItem(title: nil, image: Resource.Image.TabBarIcon.walletImg, tag: 3)

    self.viewControllers = [overview, createTransaction, transactionHistory]
    super.viewDidLoad()
    configUITabBar()
    NotificationCenter.default.addObserver(self, selector: #selector(handleHiddenTabBar), name: .tapOnView, object: nil)
    autoHiddenTabBar()
  }

  //MARK: - Methods
  func hiddenTabBar(isHidden: Bool) {
    setTabBarHidden(isHidden, animated: true)
    /// cập nhật trạng thái của tabBar (isHidden != isHidden)
    self.isHidden = !self.isHidden
  }

  @objc func handleHiddenTabBar() {
    if isHidden {
      hiddenTabBar(isHidden: false)
      autoHiddenTabBar()
    } else {
      timer?.invalidate()
      hiddenTabBar(isHidden: true)
    }
  }

  func autoHiddenTabBar() {
    timer?.invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: timeAutoHidden, repeats: false, block: { [weak self] _ in
      guard let self = self else { return }
      self.hiddenTabBar(isHidden: true)
    })
  }

  func configUITabBar() {
    tintColor = Theme.shared.primaryColor
  }
  
}
