//
//  NumberFormatter+Extension.swift
//  MoneyLover
//
//  Created by xhieu21 on 06/04/2023.
//

import Foundation

extension NumberFormatter {
	static func getDefaultNumberFormater() -> NumberFormatter {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		formatter.minimumFractionDigits = 0
		formatter.maximumFractionDigits = 0
		formatter.groupingSeparator = "."
		formatter.decimalSeparator = ","
		return formatter
	}
}
