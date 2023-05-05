//
//  DetailReportViewController.swift
//  MoneyLover
//
//  Created by xhieu21 on 27/04/2023.
//

import UIKit
import Charts

class DetailReportViewController: UIViewController {

	@IBOutlet weak var pieChart: PieChartView!
	@IBOutlet weak var totalExpense: UILabel!
	@IBOutlet weak var tableView: UITableView!

	let detailReportManager = DetailReportManager()

	override func viewDidLoad() {
		super.viewDidLoad()
		totalExpense.text = detailReportManager.totalExpense.formatMoneyNumber() + " " + Resource.Title.vnd
		configTableView()
		performPieChart()
	}

	private func configTableView() {
		tableView.dataSource = self
		tableView.separatorStyle = .none
		tableView.register(DetailReportCell.nib(), forCellReuseIdentifier: DetailReportCell.identifier)
	}

	private func performPieChart() {
		pieChart.delegate = self
		pieChart.legend.enabled = false
		pieChart.holeRadiusPercent = 0.4
		pieChart.setExtraOffsets(left: 10, top: 10, right: 10, bottom: 10)

		var dataEntries: [ChartDataEntry] = []
		for item in detailReportManager.expenseTransactions {
			let ratio = (item.amount ?? 0.0) / detailReportManager.totalExpense
			let dataEntry = PieChartDataEntry(value: item.amount ?? 0.0)
			dataEntry.icon = UIImage(named: item.group?.image ?? "")?.resized(to: CGSize(width: 30, height: 30))
			dataEntry.label = ratio.toPercent()
			dataEntries.append(dataEntry)
		}

		let pieChartDataSet = PieChartDataSet(entries: dataEntries)
		pieChartDataSet.drawValuesEnabled = false
		pieChartDataSet.iconsOffset = CGPoint(x: 0, y: 55)
		pieChartDataSet.colors = ChartColorTemplates.joyful()
		pieChartDataSet.sliceSpace = 2.0
		pieChartDataSet.entryLabelColor = .black
		pieChartDataSet.entryLabelFont = UIFont.systemFont(ofSize: 14, weight: .semibold)

		let pieChartData = PieChartData(dataSet: pieChartDataSet)
		pieChart.data = pieChartData
		pieChart.animate(xAxisDuration: 0.5, yAxisDuration: 1.0, easingOption: .easeInOutQuad)
	}

}

//MARK: - Conform UITableViewDataSource
extension DetailReportViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return detailReportManager.expenseTransactions.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: DetailReportCell.identifier, for: indexPath) as? DetailReportCell
		guard let cell = cell else { return UITableViewCell() }
		let transaction = detailReportManager.expenseTransactions[indexPath.row]
		cell.setupView(imageName: transaction.group?.image, rightLabel: transaction.group?.name, leftLabel: transaction.amount)
		return cell
	}

}

//MARK: - Conform ChartViewDelegate
extension DetailReportViewController: ChartViewDelegate {
	func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
		let index = Int(highlight.x)
		guard let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) else { return }
		UIView.animate(withDuration: 0.2, delay: 0, options: [.allowUserInteraction], animations: {
			cell.contentView.backgroundColor = .systemGray5
		}) { _ in
			UIView.animate(withDuration: 1.0, delay: 0, options: [.allowUserInteraction], animations: {
				cell.contentView.backgroundColor = .white
			}, completion: nil)
		}
	}
}
