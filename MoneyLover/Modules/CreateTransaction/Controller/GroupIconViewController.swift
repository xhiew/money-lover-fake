//
//  GroupIconViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 11/04/2023.
//

import UIKit

class GroupIconViewController: UIViewController {

	@IBOutlet weak var collectionView: UICollectionView!

	var groupIconDataSource: [String] = []
	var didSelectItem: ((IndexPath) -> Void)?

	override func viewDidLoad() {
		super.viewDidLoad()
		configCollectionView()
	}

	func configCollectionView() {
		collectionView.dataSource = self
		collectionView.delegate = self
		collectionView.register(GroupIconViewCell.nib(), forCellWithReuseIdentifier: GroupIconViewCell.identifier)
	}

	@IBAction func backButtonAction(_ sender: Any) {
		navigationController?.popViewController(animated: true)
	}

}

//MARK: - Conform UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension GroupIconViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return groupIconDataSource.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupIconViewCell.identifier, for: indexPath) as? GroupIconViewCell
		guard let cell = cell else { return UICollectionViewCell() }
		cell.setImage(imageString: groupIconDataSource[indexPath.row])
		return cell
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: collectionView.bounds.width/5, height: collectionView.bounds.width/5)
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 0.0
	}

	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 0.0
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		didSelectItem?(indexPath)
		navigationController?.popViewController(animated: true)
	}

}
