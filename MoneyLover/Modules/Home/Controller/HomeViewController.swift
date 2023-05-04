//
//  HomeViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 13/03/2023.
//

import UIKit

class HomeViewController: BaseViewController {

  @IBOutlet weak var homeTableView: UITableView!
	
	var homeManager = HomeManager()

  override func viewDidLoad() {
    super.viewDidLoad()
    configTableView()
		homeManager.attachView(delegate: self)
		NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: .changedAmount, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(refetchTransactionInRealm(_:)), name: .createdNewTransaction, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(reloadView), name: .deletedTransaction, object: nil)
  }

	@objc private func updateUI() {
		homeManager.reloadRecentViewAndWallet()
	}

	@objc private func reloadView() {
		homeManager.reloadHomeView()
	}

	@objc private func refetchTransactionInRealm(_ notification: Notification) {
		if let transaction = notification.object as? Transaction {
			homeManager.reloadHomeViewWhenCreatedNewTransaction(newTransaction: transaction)
		}
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
		homeTableView.register(TheEndCell.nib(), forCellReuseIdentifier: TheEndCell.identifier)
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
      guard let cell = cell else { return UITableViewCell() }
			cell.accountBalance = self.homeManager.currentAmount
      return cell
    case .myWallet:
      let cell = homeTableView.dequeueReusableCell(withIdentifier: MyWalletCell.identifier, for: indexPath) as? MyWalletCell
      guard let cell = cell else { return UITableViewCell() }
			cell.currentAmount = homeManager.currentAmount
			cell.changeAmount = { [weak self] in
				let alert = UIAlertController(title: Resource.ActionTitle.fineTuneWallet, message: nil, preferredStyle: .actionSheet)
				let changeAccBalance = UIAlertAction(title: Resource.ActionTitle.fineTuneAmount, style: .default) { [weak self] _ in
					let vc = PopUpInputController()
					self?.present(vc, animated: true, completion: nil)
				}
				alert.addAction(changeAccBalance)
				alert.addAction(UIAlertAction(title: Resource.ActionTitle.cancel, style: .cancel, handler: nil))
				self?.present(alert, animated: true, completion: nil)
			}
      return cell
    case .header(title: let title):
      let cell = homeTableView.dequeueReusableCell(withIdentifier: HeaderCell.identifier, for: indexPath) as? HeaderCell
      guard let cell = cell else { return UITableViewCell() }
      cell.setTitle(title: title)
      return cell
    case .promo:
      let cell = homeTableView.dequeueReusableCell(withIdentifier: PromotionCell.identifier, for: indexPath) as? PromotionCell
      guard let cell = cell else { return UITableViewCell() }

      return cell
    case .personalPlan:
      let cell = homeTableView.dequeueReusableCell(withIdentifier: PersonalPlanCell.identifier, for: indexPath) as? PersonalPlanCell
      guard let cell = cell else { return UITableViewCell() }
			cell.registedNotification = {
				Commons.shared.showToast(image: Resource.Image.systemSuccess?.withTintColor(Theme.shared.greenButtonColor, renderingMode: .alwaysOriginal), title: Resource.NotiTitle.successTitleVi, subtitle: Resource.NotiTitle.subscribedNotiSubtitle)
			}
      return cell
    case .expenseReport:
      let cell = homeTableView.dequeueReusableCell(withIdentifier: ExpenseReportCell.identifier, for: indexPath) as? ExpenseReportCell
      guard let cell = cell else { return UITableViewCell() }

			cell.maxWeeklyExpenses = homeManager.maxWeeklyExpenses
			cell.maxMonthlyExpenses = homeManager.maxMonthlyExpenses
			cell.totalThisMonthExpenses = homeManager.totalThisMonthExpenses
			cell.totalThisWeekExpenses = homeManager.totalThisWeekExpenses
			cell.totalLastMonthExpenses = homeManager.totalLastMonthExpenses
			cell.totalLastWeekExpenses = homeManager.totalLastWeekExpenses

			cell.showMaxExpenses(maxExpenses: homeManager.maxMonthlyExpenses, totalExpense: homeManager.totalThisMonthExpenses)
			cell.showtotalExpenses(amount: homeManager.totalThisMonthExpenses)
			cell.performChart(firstYValue: homeManager.totalLastMonthExpenses, secondYValue: homeManager.totalThisMonthExpenses)

			cell.showPieChart = { [weak self] in
				guard let self = self else { return }
				let vc = DetailReportViewController()
				self.present(vc, animated: true, completion: nil)
			}
      return cell
    case .recentTransaction:
      let cell = homeTableView.dequeueReusableCell(withIdentifier: RecentTransactionCell.identifier, for: indexPath) as? RecentTransactionCell
      guard let cell = cell else { return UITableViewCell() }
			cell.showItems(transactions: homeManager.recentTransactions)
			cell.tapOnCell = { [weak self] in
				self?.tabBarController?.selectedIndex = 2
			}
      return cell
		case .theEnd:
			let cell = homeTableView.dequeueReusableCell(withIdentifier: TheEndCell.identifier, for: indexPath) as? TheEndCell
			guard let cell = cell else { return UITableViewCell() }
			return cell
    }
  }
}

//MARK: - Conform HomeManagerDelegate
extension HomeViewController: HomeManagerDelegate {
	func reloadData(_ homeManager: HomeManager) {
		homeTableView.reloadData()
	}
	
}
