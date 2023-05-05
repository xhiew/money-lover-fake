//
//  ExpenseReportCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 21/03/2023.
//

import UIKit
import Charts

enum SegCtrlType {
	case week
	case month
}

class ExpenseReportCell: BaseTableViewCell {

  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var totalExpenses: UILabel!
  @IBOutlet weak var barChart: BarChartView!
  @IBOutlet weak var stackExpenses: UIStackView!
  @IBOutlet weak var heightForStackView: NSLayoutConstraint!
  @IBOutlet weak var stateLabel: UILabel!
	@IBOutlet weak var subTitle: UILabel!

	var showPieChart: ((SegCtrlType) -> Void)?
	let numberFormatter = NumberFormatter()

	var maxWeeklyExpenses: [Transaction]?
	var maxMonthlyExpenses: [Transaction]?
	var totalThisWeekExpenses = 0.0
	var totalThisMonthExpenses = 0.0
	var totalLastWeekExpenses = 0.0
	var totalLastMonthExpenses = 0.0
	let segCtrlTypes: [SegCtrlType] = [.week, .month]

  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func configUI() {
    super.configUI()
    configSegmentedControl()
		configChart()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }

	private func configNumberFomatter(currency: Double) {
		numberFormatter.numberStyle = .currency
		numberFormatter.maximumFractionDigits = 0
		if currency >= 1_000_000 {
			numberFormatter.multiplier = 0.000001
			numberFormatter.positiveSuffix = "M"
		} else if currency >= 1_000 {
			numberFormatter.multiplier = 0.001
			numberFormatter.positiveSuffix = "K"
		} else if currency >= 1_000_000_000 {
			numberFormatter.multiplier = 0.000000001
			numberFormatter.positiveSuffix = "B"
		} else {
			numberFormatter.multiplier = 1
			numberFormatter.positiveSuffix = Resource.Title.vnd
		}
	}

  private func configChart() {
    barChart.isUserInteractionEnabled = false
    barChart.backgroundColor = .clear
    barChart.leftAxis.enabled = false
    barChart.leftAxis.spaceBottom = 0.0
    barChart.rightAxis.drawGridLinesEnabled = false
    barChart.rightAxis.drawAxisLineEnabled = false
    barChart.rightAxis.labelCount = 0
    barChart.xAxis.labelCount = 0
    barChart.xAxis.labelPosition = .bottom
		barChart.rightAxis.valueFormatter = DefaultAxisValueFormatter(formatter: numberFormatter)
    barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: [Resource.DateTitle.lastMonth, Resource.DateTitle.thisMonth])
    barChart.xAxis.drawGridLinesEnabled = false
    barChart.legend.enabled = false

  }

  private func configSegmentedControl() {
		segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
  }

	func showtotalExpenses(amount: Double) {
		totalExpenses.text = amount.formatMoneyNumber() + " " + Resource.Title.vnd
	}

	func performChart(firstYValue: Double = 0.0, secondYValue: Double = 0.0) {
		let currency = firstYValue > secondYValue ? firstYValue : secondYValue
		configNumberFomatter(currency: currency)
    let lastMonth = BarChartDataEntry(x: 0.0, yValues: [firstYValue])
    let thisMonth = BarChartDataEntry(x: 1.0, yValues: [secondYValue])
    let set = BarChartDataSet(entries: [lastMonth, thisMonth])
    set.colors = ChartColorTemplates.material()
    set.drawValuesEnabled = false
    let data = BarChartData(dataSet: set)
    data.barWidth = 0.5
    barChart.data = data
    barChart.animate(yAxisDuration: 0.5)
  }

	func showMaxExpenses(maxExpenses: [Transaction]?, totalExpense: Double) {
		clearStack()
		guard let maxExpenses = maxExpenses?.prefix(3) else { return }
		if maxExpenses.isEmpty {
			stateLabel.isHidden = false
			return
		} else {
			stateLabel.isHidden = true
		}
    for maxExpense in maxExpenses {
      let view = TransactionItemView()
			let percent = ((maxExpense.amount ?? 0.0) / totalExpense).toPercent()
			view.setupReportTransactionUI(image: maxExpense.group?.image, name: maxExpense.group?.name, amount: maxExpense.amount, percent: percent)
      stackExpenses.addArrangedSubview(view)
      view.snp.makeConstraints { make in
        make.width.equalTo(stackExpenses)
      }
    }
		let numberOfItem = maxExpenses.count
    heightForStackView.constant = Demension.shared.heightForItemTransaction * CGFloat(numberOfItem) + Demension.shared.stackSpacing * CGFloat(numberOfItem - 1)
  }

	private func clearStack() {
		stackExpenses.arrangedSubviews.forEach({$0.removeFromSuperview()})
	}

	@IBAction func didTapOnStack(_ sender: Any) {
		if stateLabel.isHidden {
			showPieChart?(segCtrlTypes[segmentedControl.selectedSegmentIndex])
		}
	}

	@IBAction func segCtrlValueChanged(_ sender: UISegmentedControl) {
		switch segCtrlTypes[sender.selectedSegmentIndex] {
		case .week:
			showMaxExpenses(maxExpenses: maxWeeklyExpenses, totalExpense: totalThisWeekExpenses)
			showtotalExpenses(amount: totalThisWeekExpenses)
			performChart(firstYValue: totalLastWeekExpenses, secondYValue: totalThisWeekExpenses)

			subTitle.text = Resource.Title.totalThisWeekExpenses
			barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: [Resource.DateTitle.lastWeek, Resource.DateTitle.thisWeek])
		case .month:
			showMaxExpenses(maxExpenses: maxMonthlyExpenses, totalExpense: totalThisMonthExpenses)
			showtotalExpenses(amount: totalThisMonthExpenses)
			performChart(firstYValue: totalLastMonthExpenses, secondYValue: totalThisMonthExpenses)

			subTitle.text = Resource.Title.totalThisMonthExpenses
			barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: [Resource.DateTitle.lastMonth, Resource.DateTitle.thisMonth])
		}
	}
	
}
