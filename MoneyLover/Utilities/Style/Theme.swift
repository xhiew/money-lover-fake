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

	/// green
  public var primaryColor: UIColor {
    return UIColor(hexString: "5DCC00")
  }

	/// yellow
	public var warningColor: UIColor {
		return UIColor(hexString: "FBB601")
	}

	/// gray
	public var disableColor: UIColor {
		return .systemGray4
	}

	/// strong green
	public var greenButtonColor: UIColor {
		return UIColor(hexString: "29C83F")
	}

	public var lightRed: UIColor {
		return UIColor(hexString: "FF5F58")
	}

	public var lightBlue: UIColor {
		return UIColor(hexString: "4169E1")
	}

}
