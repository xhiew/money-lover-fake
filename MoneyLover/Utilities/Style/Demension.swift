//
//  Demension.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/03/2023.
//

import UIKit

public class Demension {
  public static var shared = Demension()

  var widthScale: CGFloat = 1.0
  var heightScale: CGFloat = 1.0

  private init() {
    let widthIp6: CGFloat = 375.0
    let heightIp6: CGFloat = 667.0
    widthScale = UIScreen.main.bounds.width / widthIp6
    heightScale = UIScreen.main.bounds.height / heightIp6
  }

  public var heightForCategory: CGFloat = 60.0
  public var stackSpacing: CGFloat = 16.0
}
