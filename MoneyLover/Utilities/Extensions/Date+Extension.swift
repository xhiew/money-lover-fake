//
//  Date+Extension.swift
//  MoneyLover
//
//  Created by xhieu21 on 13/04/2023.
//

import UIKit

extension Date {

	/// lấy "Tháng trước", "Tháng hiện tại",  "Tương lai" + "Các tháng trong quá khứ gần nhất" sao cho đủ 20 tháng
	///  i - 19 để sắp xếp theo đúng thứ tự thời gian, 19 là để lấy từ quá khứ tới "tháng trước nữa" của "tháng trước"
	func getTwentyRecentMonths() -> [String] {
		var monthNames: [String] = []
		for i in 1...17 {
			let month = Date().adding(.month, value: (i - 19))
			monthNames.append(month.monthAndYearString())
		}
		monthNames.append(Resource.DateTitle.lastMonth.uppercased())
		monthNames.append(Resource.DateTitle.thisMonth.uppercased())
		monthNames.append(Resource.DateTitle.future.uppercased())
		return monthNames
	}

	func monthAndYearString() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/yyyy"
		return dateFormatter.string(from: self)
	}

}
