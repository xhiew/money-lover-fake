//
//  CreateGroupViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 11/04/2023.
//

import UIKit

class CreateGroupViewController: BaseViewController {
	@IBOutlet weak var saveButtonOutlet: UIButton!
	@IBOutlet weak var textField: UITextField!
	@IBOutlet weak var groupAva: UIImageView!
	@IBOutlet weak var segmentedOutlet: UISegmentedControl!
	@IBOutlet weak var groupTypeArrowDown: UIImageView!
	@IBOutlet weak var groupTypeButtonOutlet: UIButton!
	@IBOutlet weak var groupTypeLabel: UILabel!

	let createGroupManager = CreateGroupManager()
	var sucessDeleteGroup: (() -> Void)?

	private var isActive: Bool = false {
		didSet {
			checkSaveButton()
		}
	}

	private var isRevenue: Bool = false {
		didSet {
			configUIGroupTypeRow()
		}
	}

	private var isNotEmptyName: Bool = false {
		didSet {
			checkConditions()
		}
	}

	private var isNotEmptyImage: Bool = false {
		didSet {
			checkConditions()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		checkSaveButton()
		setDefaultIsExpense()
		createGroupManager.attachView(view: self)
	}

	private func checkConditions() {
		if isNotEmptyName, isNotEmptyImage, groupTypeLabel.text != Resource.Title.GroupTypeTitle.groupType {
			isActive = true
		} else {
			isActive = false
		}
	}

	private func configUIGroupTypeRow() {
		groupTypeButtonOutlet.isEnabled = !isRevenue
		groupTypeArrowDown.isHidden = isRevenue
		if isRevenue {
			groupTypeLabel.text = Resource.Title.GroupTypeTitle.revenue
			groupTypeLabel.textColor = .black
			createGroupManager.newGroup.groupType = .revenue
		} else {
			groupTypeLabel.text = Resource.Title.GroupTypeTitle.groupType
			groupTypeLabel.textColor = .systemGray3
		}
	}

	private func setDefaultIsExpense() {
		segmentedOutlet.selectedSegmentIndex = 1
		createGroupManager.newGroup.isExpense = true
	}

	private func checkSaveButton() {
		if isActive {
			saveButtonOutlet.backgroundColor = Theme.shared.greenButtonColor
		} else {
			saveButtonOutlet.backgroundColor = Theme.shared.disableColor
		}
	}

	@IBAction func saveButtonAction(_ sender: Any) {
		if isActive {
			createGroupManager.createNewGroup()
		} else {
			Commons.shared.showToast(image: Resource.Image.systemError,
															 title: Resource.NotiTitle.warningTitle,
															 subtitle: Resource.NotiTitle.warningSubtitle)
		}
	}

	@IBAction func changeGroupIcon(_ sender: Any) {
		let vc = GroupIconViewController()
		vc.groupIconDataSource = createGroupManager.groupIcons
		vc.didSelectItem = { [weak self] indexPath in
			guard let self = self else { return }
			let imageString = self.createGroupManager.groupIcons[indexPath.row]
			self.groupAva.image = UIImage(named: imageString)
			self.createGroupManager.newGroup.image = imageString
			self.isNotEmptyImage = true
		}
		navigationController?.pushViewController(vc, animated: true)
	}

	@IBAction func changeGroupType(_ sender: Any) {
		let vc = GroupTypeViewController()
		vc.groupTypes = createGroupManager.groupTypes
		vc.didSelectGroupType = { [weak self] indexPath in
			guard let self = self else { return }
			let groupType = self.createGroupManager.groupTypes[indexPath.row]
			self.groupTypeLabel.text = groupType.toString()
			self.groupTypeLabel.textColor = .black
			self.createGroupManager.newGroup.groupType = groupType
			self.checkConditions()
		}
		presentPanModal(vc)
	}

	@IBAction func segmentedControlValueChange(_ sender: UISegmentedControl) {
		switch createGroupManager.segmentedItem[sender.selectedSegmentIndex] {
		case .revenue:
			isRevenue = true
			createGroupManager.newGroup.isExpense = false
		case .expense:
			isRevenue = false
			createGroupManager.newGroup.isExpense = true
		}
		checkConditions()
	}

	@IBAction func backButtonAction(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}

	@IBAction func textFieldValueChanged(_ sender: UITextField) {
		if sender.text?.count ?? 0 > 35 {
			sender.text?.removeLast()
		}
		if sender.text?.isEmpty ?? false {
			isNotEmptyName = false
		} else {
			isNotEmptyName = true
			createGroupManager.newGroup.name = sender.text?.trimmingCharacters(in: .whitespaces)
		}
	}

}

//MARK: - Conform CreateGroupManagerDelegate
extension CreateGroupViewController: CreateGroupManagerDelegate {
	func handleSucessCreateGroup(_ createGroupManager: CreateGroupManager) {
		navigationController?.popViewController(animated: true)
		sucessDeleteGroup?()
	}

	func handleFailedCreateGroup(_ createGroupManager: CreateGroupManager) {

	}
}
