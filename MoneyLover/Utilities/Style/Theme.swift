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
}
