//
//  Double+Extension.swift
//  MoneyLover
//
//  Created by xhieu21 on 06/04/2023.
//

import Foundation

enum ShortCurrencyType {
	case short
	case medium
}

extension Double {

	func toPercent() -> String {
		let per = Int(self*100)
		return String(describing: per) + "%"
	}

	func shortCurrency(shortType: ShortCurrencyType = .short) -> String {
		var types: [String] = []
		var last = ""
		switch shortType {
		case .short:
			types = ["K", "M", "B"]
			last = "Đ"
		case .medium:
			types = ["Nghìn", "Triệu", "Tỉ"]
			last = "Đồng"
		}
		var value = self
		for type in types {
			if value / 1000 < 1 {
				break
			} else {
				value /= 1000
				last = type
			}
		}
		return value.currencyFormat + "" + last
	}

	func formatNumber(maxFraction: Int = 2) -> String {
		let currencyStyle = NumberFormatter()
		currencyStyle.numberStyle = .decimal
		currencyStyle.maximumFractionDigits = maxFraction
		currencyStyle.roundingMode = .up

		let formatedString = currencyStyle.string(from: NSNumber(value: self)) ?? ""
		return formatedString
	}

	func formatMoneyNumber(maxFraction: Int = 0) -> String {
		let currencyStyle = NumberFormatter()
		currencyStyle.numberStyle = .decimal
		currencyStyle.maximumFractionDigits = maxFraction
		currencyStyle.roundingMode = .up

		let locale = Locale.current
		currencyStyle.locale = locale
		currencyStyle.groupingSeparator = "."
		currencyStyle.decimalSeparator = ","
		currencyStyle.groupingSize = 3
		currencyStyle.alwaysShowsDecimalSeparator = false
		currencyStyle.usesGroupingSeparator = true
		currencyStyle.isLenient = true
		let formatedString = currencyStyle.string(from: NSNumber(value: self)) ?? ""
		return formatedString
	}

	var currencyFormat: String {
		let formatter =  NumberFormatter.getDefaultNumberFormater()
		return formatter.string(from: NSNumber(value: self)) ?? String(format: ".2f", self)
	}

}
