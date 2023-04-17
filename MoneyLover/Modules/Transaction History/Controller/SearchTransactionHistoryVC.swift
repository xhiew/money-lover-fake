//
//  SearchTransactionHistoryVC.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/04/2023.
//

import UIKit

class SearchTransactionHistoryVC: BaseViewController {

	@IBOutlet weak var searchBar: UISearchBar!

	override func viewDidLoad() {
		super.viewDidLoad()
		searchBar.delegate = self
	}

	@IBAction func dismissButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

}

//MARK: - Conform UISearchBarDelegate
extension SearchTransactionHistoryVC: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		print(searchText)
	}

	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		view.endEditing(true)
	}
}
