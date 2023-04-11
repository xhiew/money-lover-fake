//
//  CreateTransactionController.swift
//  MoneyLover
//
//  Created by xhieu21 on 05/04/2023.
//

import UIKit
import PanModal

class CreateTransactionController: BaseViewController {

	//MARK: - Properties
  @IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var greenButtonOutlet: UIButton!

	var selectedGroupIndexPath: IndexPath?

	var isEnableGreenButton: Bool = false {
		didSet {
			configGreenButton()
		}
	}

	var isNotEmptyAmount: Bool = false {
		didSet {
			checkConditions()
		}
	}

	var isNotEmptyGroup: Bool = false {
		didSet {
			checkConditions()
		}
	}

	let createTransactionManager = CreateTransactionManager()

	//MARK: - LifeCycle
  override func viewDidLoad() {
    super.viewDidLoad()
		configTableView()
		configGreenButton()
  }

	//MARK: - Methods
	func configTableView() {
		tableView.dataSource = self
		tableView.contentInset = UIEdgeInsets(horizontal: 0.0, vertical: 70.0)
		tableView.separatorStyle = .none
		tableView.register(AmountViewCell.nib(), forCellReuseIdentifier: AmountViewCell.identifier)
		tableView.register(GroupViewCell.nib(), forCellReuseIdentifier: GroupViewCell.identifier)
		tableView.register(MiscViewCell.nib(), forCellReuseIdentifier: MiscViewCell.identifier)
		tableView.register(IgnoreViewCell.nib(), forCellReuseIdentifier: IgnoreViewCell.identifier)
	}

	private func configGreenButton() {
		if isEnableGreenButton {
			greenButtonOutlet.backgroundColor = Theme.shared.greenButtonColor
		} else {
			greenButtonOutlet.backgroundColor = Theme.shared.disableColor
		}
	}

	private func checkConditions() {
		if isNotEmptyAmount, isNotEmptyGroup {
			isEnableGreenButton = true
		}
	}

  @IBAction func didTapRedButton(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }

  @IBAction func didTapGreenButton(_ sender: Any) {
		if isEnableGreenButton {
			Commons.shared.showToast(image: Resource.Image.systemSuccess,
															 title: Resource.Title.CreateTransactionTitle.successTitle,
															 subtitle: Resource.Title.CreateTransactionTitle.successSubtitle)
			// lưu giao dịch , nhớ check xem có ignore report ko
		} else {
			Commons.shared.showToast(image: Resource.Image.systemError,
															 title: Resource.Title.CreateTransactionTitle.warningTitle,
															 subtitle: Resource.Title.CreateTransactionTitle.warningSubtitle)
		}
  }
}

//MARK: - Conform UITableViewDataSource
extension CreateTransactionController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Commons.shared.numberOfRowsInSection
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return createTransactionManager.createViewItem.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch createTransactionManager.createViewItem[indexPath.section] {
		case .amount:
			let cell = tableView.dequeueReusableCell(withIdentifier: AmountViewCell.identifier, for: indexPath) as? AmountViewCell
			guard let cell = cell else { return UITableViewCell() }
			cell.getAmount = { [weak self] amount in
				if let self = self, let amount = amount {
					if amount > 0 {
						self.createTransactionManager.newTransaction.amount = amount
						self.isNotEmptyAmount = true
					} else {
						self.isNotEmptyAmount = false
						self.isEnableGreenButton = false
					}
				}
			}
			return cell
		case .group:
			let cell = tableView.dequeueReusableCell(withIdentifier: GroupViewCell.identifier, for: indexPath) as? GroupViewCell
			guard let cell = cell else { return UITableViewCell() }
			cell.delegate = self
			return cell
		case .note:
			let cell = tableView.dequeueReusableCell(withIdentifier: MiscViewCell.identifier, for: indexPath) as? MiscViewCell
			guard let cell = cell else { return UITableViewCell() }
			cell.delegate = self
			cell.miscType = .note
			cell.setupUI(image: Resource.Image.systemNote, title: Resource.Title.note)
			return cell
		case .date:
			let cell = tableView.dequeueReusableCell(withIdentifier: MiscViewCell.identifier, for: indexPath) as? MiscViewCell
			guard let cell = cell else { return UITableViewCell() }
			cell.delegate = self
			cell.miscType = .date
			cell.setupUI(image: Resource.Image.systemCalendar, title: createTransactionManager.today)
			return cell
		case .ignore:
			let cell = tableView.dequeueReusableCell(withIdentifier: IgnoreViewCell.identifier, for: indexPath) as? IgnoreViewCell
			guard let cell = cell else { return UITableViewCell() }
			cell.switchValueChange = { [weak self] isIgnore in
				self?.createTransactionManager.isIgnoreReport = isIgnore
			}
			cell.showPopUp = { [weak self] in
				guard let self = self else { return }
				let popUp = PopUpInfoController()
				popUp.messageTitle = Resource.Title.titleIgnoreReport
				popUp.messageContent = Resource.Title.descriptionIgnoreReport
				self.presentPanModal(popUp)
			}
			return cell
		}
	}
}

//MARK: - Conform MiscViewDelegate
extension CreateTransactionController: MiscViewDelegate {
	func didTapMiscView(_ cell: MiscViewCell, miscType: CreateViewItem) {
		switch miscType {
		case .note:
			let noteVC = NoteViewController()
			noteVC.isModalInPresentation = true
			if cell.itemTitle.text != Resource.Title.note {
				noteVC.currentText = createTransactionManager.newTransaction.note ?? ""
			}
			noteVC.getNote = { [weak self] note in
				guard let self = self, let note = note else { return }
				if !note.isEmpty {
					self.createTransactionManager.newTransaction.note = note
					cell.itemTitle.text = note.prefix(30).description
				} else {
					self.createTransactionManager.newTransaction.note = note
					cell.itemTitle.text = Resource.Title.note
				}
			}
			navigationController?.pushViewController(noteVC, animated: true)
		case .date:
			let dateVC = DateViewController()
			if let date = createTransactionManager.newTransaction.date {
				dateVC.setDate = date
			}
			dateVC.sendDate = { [weak self] date in
				self?.createTransactionManager.newTransaction.date = date
				cell.itemTitle.text = date.dateString(ofStyle: .full)
			}
			self.presentPanModal(dateVC)
		default:
			return
		}
	}
}

//MARK: - Conform GroupViewCellDelegate
extension CreateTransactionController: GroupViewCellDelegate {
	func selectGroup(_ cell: GroupViewCell, group: TransactionGroup?) {
		let groupVC = GroupViewController()
		groupVC.selectedGroupIndexPath = selectedGroupIndexPath
		groupVC.delegate = self
		groupVC.isModalInPresentation = true
		navigationController?.pushViewController(groupVC, animated: true)
	}
}

//MARK: - Conform GroupViewControllerDelegate
extension CreateTransactionController: GroupViewControllerDelegate {
	func didSelectGroupItem(_ sender: GroupViewController, indexPath: IndexPath, group: TransactionGroup) {
		self.selectedGroupIndexPath = indexPath
		if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? GroupViewCell {
			self.isNotEmptyGroup = true
			cell.setupUI(imageName: group.image, title: group.name)
			self.createTransactionManager.newTransaction.group = group
		}
	}

}

