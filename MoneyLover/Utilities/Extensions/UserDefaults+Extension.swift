//
//  UserDefaults+Extension.swift
//  MoneyLover
//
//  Created by xhieu21 on 07/04/2023.
//

import Foundation

extension UserDefaults {

	private enum UserDefaultsKey: String {
		case accountBalance
		case isFirstLaunch
		case isHiddenAmount
		case isSubscribed
	}

	var accountBalance: Double {
		get {
			return self.double(forKey: UserDefaultsKey.accountBalance.rawValue)
		}
		set {
			self.setValuesForKeys([UserDefaultsKey.accountBalance.rawValue : newValue])
		}
	}

	var isNotFirstLaunch: Bool {
		get {
			return self.bool(forKey: UserDefaultsKey.isFirstLaunch.rawValue)
		}
		set {
			self.setValuesForKeys([UserDefaultsKey.isFirstLaunch.rawValue : newValue])
		}
	}

	var isHiddenAmount: Bool {
		get {
			return self.bool(forKey: UserDefaultsKey.isHiddenAmount.rawValue)
		}
		set {
			self.setValuesForKeys([UserDefaultsKey.isHiddenAmount.rawValue: newValue])
		}
	}

	var isSubscribed: Bool {
		get {
			return self.bool(forKey: UserDefaultsKey.isSubscribed.rawValue)
		}
		set {
			self.setValuesForKeys([UserDefaultsKey.isSubscribed.rawValue: newValue])
		}
	}

}
