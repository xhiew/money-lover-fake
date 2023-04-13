//
//  ExpenseReportCell.swift
//  MoneyLover
//
//  Created by xhieu21 on 21/03/2023.
//

import UIKit
import Charts

class ExpenseReportCell: BaseTableViewCell {

  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var totalExpenses: UILabel!
  @IBOutlet weak var barChart: BarChartView!
  @IBOutlet weak var stackExpenses: UIStackView!
  @IBOutlet weak var heightForStackView: NSLayoutConstraint!
  @IBOutlet weak var stateLabel: UILabel!
	@IBOutlet weak var subTitle: UILabel!

  var maxWeeklyExpenses: [Transaction]?
  var maxMonthlyExpenses: [Transaction]?
  var totalWeeklyExpenses: Double?
  var totalMonthlyExpenses: Double?

  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code

  }

  override func configUI() {
    super.configUI()
    configSegmentedControl()
    configChart()

  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
  }

  func configChart() {
    barChart.isUserInteractionEnabled = false
    barChart.backgroundColor = .clear
    barChart.leftAxis.enabled = false
    barChart.leftAxis.spaceBottom = 0.0
    barChart.rightAxis.drawGridLinesEnabled = false
    barChart.rightAxis.drawAxisLineEnabled = false
    barChart.rightAxis.labelCount = 2
    barChart.xAxis.labelCount = 0
    barChart.xAxis.labelPosition = .bottom
    barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: [Resource.DateTitle.lastMonth, Resource.DateTitle.thisMonth])
    barChart.xAxis.drawGridLinesEnabled = false
    barChart.legend.enabled = false

  }

  func configSegmentedControl() {
		segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: .normal)
  }

  func performChart() {
    let lastMonth = BarChartDataEntry(x: 0.0, yValues: [142])
    let thisMonth = BarChartDataEntry(x: 1.0, yValues: [200])
    let set = BarChartDataSet(entries: [lastMonth, thisMonth])
    set.colors = ChartColorTemplates.material()
    set.drawValuesEnabled = false
    let data = BarChartData(dataSet: set)
    data.barWidth = 0.5
    barChart.data = data
    barChart.animate(yAxisDuration: 0.5)
  }

  func showMaxExpenses(maxExpenses: [Transaction]?) {
    guard let maxExpense = maxExpenses else {
      return
    }
    guard stackExpenses.arrangedSubviews.isEmpty else { return }
    stateLabel.isHidden = true
    for maxExpense in maxExpense {
      let view = TransactionItemView()
      view.setupUI(image: maxExpense.group?.image, title: maxExpense.group?.name, subTitle: "200,000", rightTitle: "21%")
      stackExpenses.addArrangedSubview(view)
      view.snp.makeConstraints { make in
        make.width.equalTo(stackExpenses)
      }
    }
    let numberOfItem = maxExpenses?.count ?? 0
    heightForStackView.constant = Demension.shared.heightForItemTransaction * CGFloat(numberOfItem) + Demension.shared.stackSpacing * CGFloat(numberOfItem - 1)
  }

}
