//
//  String+Extension.swift
//  MoneyLover
//
//  Created by xhieu21 on 06/04/2023.
//

import Foundation

extension String {
	var currency: Double {
		return self.replacingOccurrences(of: ".", with: "", options: NSString.CompareOptions.literal, range: nil).toDouble()
	}

	func toDouble() -> Double {
		if let value = Double(self) {
			return value
		}
		return 0.0
	}
}
