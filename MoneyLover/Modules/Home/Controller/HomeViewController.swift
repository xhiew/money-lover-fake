//
//  HomeViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 13/03/2023.
//

import UIKit

class HomeViewController: BaseViewController {

  @IBOutlet weak var homeTableView: UITableView!
  let homeManager = HomeManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    configTableView()
    
  }

  func configTableView() {
    homeTableView.dataSource = self
    homeTableView.separatorStyle = .none
    homeTableView.register(AccountBalanceCell.nib(), forCellReuseIdentifier: AccountBalanceCell.identifier)
    homeTableView.register(MyWalletCell.nib(), forCellReuseIdentifier: MyWalletCell.identifier)
    homeTableView.register(HeaderCell.nib(), forCellReuseIdentifier: HeaderCell.identifier)
    homeTableView.register(PromotionCell.nib(), forCellReuseIdentifier: PromotionCell.identifier)
    homeTableView.register(PersonalPlanCell.nib(), forCellReuseIdentifier: PersonalPlanCell.identifier)
    homeTableView.register(ExpenseReportCell.nib(), forCellReuseIdentifier: ExpenseReportCell.identifier)
    homeTableView.register(RecentTransactionCell.nib(), forCellReuseIdentifier: RecentTransactionCell.identifier)
  }

}

//MARK: - Conform UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Commons.shared.numberOfRowsInSection
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return homeManager.homeItem.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch homeManager.homeItem[indexPath.section] {
    case .accBalance:
      let cell = homeTableView.dequeueReusableCell(withIdentifier: AccountBalanceCell.identifier, for: indexPath) as? AccountBalanceCell
      guard let cell = cell else { return AccountBalanceCell() }
      cell.accountBalance = "999,999,999"
      return cell
    case .myWallet:
      let cell = homeTableView.dequeueReusableCell(withIdentifier: MyWalletCell.identifier, for: indexPath) as? MyWalletCell
      guard let cell = cell else { return MyWalletCell() }

      return cell
    case .header(title: let title):
      let cell = homeTableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as? HeaderCell
      guard let cell = cell else { return HeaderCell() }
      cell.setTitle(title: title)
      return cell
    case .promo:
      let cell = homeTableView.dequeueReusableCell(withIdentifier: PromotionCell.identifier, for: indexPath) as? PromotionCell
      guard let cell = cell else { return PromotionCell() }

      return cell
    case .personalPlan:
      let cell = homeTableView.dequeueReusableCell(withIdentifier: PersonalPlanCell.identifier, for: indexPath) as? PersonalPlanCell
      guard let cell = cell else { return PersonalPlanCell() }

      return cell
    case .expenseReport:
      let cell = homeTableView.dequeueReusableCell(withIdentifier: ExpenseReportCell.identifier, for: indexPath) as? ExpenseReportCell
      guard let cell = cell else { return ExpenseReportCell() }
      cell.maxMonthlyExpenses = homeManager.expenses
      cell.performChart()
      cell.showMaxExpenses(maxExpenses: homeManager.expenses)

      return cell
    case .recentTransaction:
      let cell = homeTableView.dequeueReusableCell(withIdentifier: RecentTransactionCell.identifier, for: indexPath) as? RecentTransactionCell
      guard let cell = cell else { return RecentTransactionCell() }
      cell.showItems(transactions: homeManager.expenses)

      return cell
    }
  }
}
