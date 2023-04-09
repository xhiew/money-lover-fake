//
//  Theme.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/03/2023.
//

import UIKit

public class Theme {
  public static var shared = Theme()

  private init() {}

  public var primaryColor: UIColor {
    return UIColor(hexString: "5DCC00")
  }

	public var warningColor: UIColor {
		return UIColor(hexString: "FBB601")
	}

	public var disableColor: UIColor {
		return .systemGray4
	}

	public var greenButtonColor: UIColor {
		return UIColor(hexString: "29C83F")
	}

}
