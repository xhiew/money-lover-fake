//
//  GroupTypeViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 11/04/2023.
//

import UIKit
import PanModal

class GroupTypeViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	var groupTypes: [GroupType] = []
	var didSelectGroupType: ((IndexPath) -> Void)?

	override func viewDidLoad() {
		super.viewDidLoad()
		configTableView()
	}

	private func configTableView() {
		tableView.dataSource = self
		tableView.delegate = self
		tableView.register(GroupTypeViewCell.nib(), forCellReuseIdentifier: GroupTypeViewCell.identifier)
	}

}

//MARK: - Conform UITableViewDelegate, UITableViewDataSource
extension GroupTypeViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return groupTypes.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: GroupTypeViewCell.identifier, for: indexPath) as? GroupTypeViewCell
		guard let cell = cell else { return UITableViewCell() }
		cell.setupUI(mainTitle: groupTypes[indexPath.row].toString(), subTitle: groupTypes[indexPath.row].description())
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		didSelectGroupType?(indexPath)
		dismiss(animated: true, completion: nil)
	}
	
}

//MARK: - Conform PanModalPresentable
extension GroupTypeViewController: PanModalPresentable {
	var panScrollable: UIScrollView? {
		return nil
	}

	var longFormHeight: PanModalHeight {
		return .contentHeight(250)
	}
}
