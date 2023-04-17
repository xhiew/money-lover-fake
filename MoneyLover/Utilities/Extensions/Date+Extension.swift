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
	static func getTwentyRecentMonths() -> [Date] {
		var months: [Date] = []
		for i in 1...20 {
			let month = Date().adding(.month, value: (i - 19))
			months.append(month)
		}
		return months
	}

	func isInThePresent(_ component: Calendar.Component) -> Bool {
		var calendar = Calendar.current
		calendar.timeZone = TimeZone(abbreviation: "UTC")!
		return calendar.isDate(self, equalTo: Date(), toGranularity: component)
	}

	func isInLastMonth() -> Bool {
		var calendar = Calendar.current
		calendar.timeZone = TimeZone(abbreviation: "UTC")!
		return calendar.isDate(self, equalTo: Date().adding(.month, value: -1), toGranularity: .month)
	}

	func nameOfTwentyMonths() -> String {
		if isInFuture {
			return Resource.DateTitle.future.uppercased()
		}
		if isInThePresent(.month) {
			return Resource.DateTitle.thisMonth.uppercased()
		}
		if isInLastMonth() {
			return Resource.DateTitle.lastMonth.uppercased()
		}
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "MM/yyyy"
		return dateFormatter.string(from: self)
	}

	func IgnoreDay() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "EEEE MMMM yyyy"
		return dateFormatter.string(from: self)
	}

	/// giống hàm beginning(of:) và end(of:) nhưng custom calendar với timeZone là 'UTC' để đổi ngày bắt đầu / kết thúc của tuần  / tháng
	/// vd tháng 4 : từ 31/3/2023 thành 1/4/2023
	/// lưu ý đối với sử dụng bắt đầu của tuần thì adding thêm 1 ngày để đổi  "từ Chủ nhật --> Thứ bảy" thành "từ Thứ 2 --> Chủ nhật" để phù hợp với việt nam hoặc sử dụng hàm startOfWeek(date:)
	func customStart(of component: Calendar.Component) -> Date? {
		var calendar = Calendar.current
		calendar.timeZone = TimeZone(abbreviation: "UTC")!
		if component == .day {
			return calendar.startOfDay(for: self)
		}

		var components: Set<Calendar.Component> {
			switch component {
			case .second:
				return [.year, .month, .day, .hour, .minute, .second]

			case .minute:
				return [.year, .month, .day, .hour, .minute]

			case .hour:
				return [.year, .month, .day, .hour]

			case .weekOfYear, .weekOfMonth:
				return [.yearForWeekOfYear, .weekOfYear]

			case .month:
				return [.year, .month]

			case .year:
				return [.year]

			default:
				return []
			}
		}
		guard !components.isEmpty else { return nil }
		return calendar.date(from: calendar.dateComponents(components, from: self))
	}

	func startOfWeek(date: Date = Date()) -> Date? {
		return date.customStart(of: .weekOfMonth)?.adding(.day, value: 1)
	}

	func customEnd(of component: Calendar.Component) -> Date? {
		var calendar = Calendar.current
		calendar.timeZone = TimeZone(abbreviation: "UTC")!
		switch component {
		case .second:
			var date = adding(.second, value: 1)
			date = calendar.date(from:
														calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date))!
			date.add(.second, value: -1)
			return date

		case .minute:
			var date = adding(.minute, value: 1)
			let after = calendar.date(from:
																	calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date))!
			date = after.adding(.second, value: -1)
			return date

		case .hour:
			var date = adding(.hour, value: 1)
			let after = calendar.date(from:
																	calendar.dateComponents([.year, .month, .day, .hour], from: date))!
			date = after.adding(.second, value: -1)
			return date

		case .day:
			var date = adding(.day, value: 1)
			date = calendar.startOfDay(for: date)
			date.add(.second, value: -1)
			return date

		case .weekOfYear, .weekOfMonth:
			var date = self
			let beginningOfWeek = calendar.date(from:
																						calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
//			date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)

			// sửa ngày kết thúc của tuần thành chủ nhật, thay vì thứ 7
			date = beginningOfWeek.adding(.day, value: 8).adding(.second, value: -1)
			return date

		case .month:
			var date = adding(.month, value: 1)
			let after = calendar.date(from:
																	calendar.dateComponents([.year, .month], from: date))!
			date = after.adding(.second, value: -1)
			return date

		case .year:
			var date = adding(.year, value: 1)
			let after = calendar.date(from:
																	calendar.dateComponents([.year], from: date))!
			date = after.adding(.second, value: -1)
			return date

		default:
			return nil
		}
	}

}
