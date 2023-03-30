//
//  UIView+Extension.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/03/2023.
//

import UIKit

extension UIView {

  func roundCorners(corners: UIRectCorner = .allCorners, radius: CGFloat = 12) {
    clipsToBounds = true
    layer.cornerRadius = radius
  }

  static func nib() -> UINib {
    return UINib(nibName: String(describing: self), bundle: nil)
  }

  static var identifier: String {
    return String(describing: self)
  }

  @IBInspectable var cornerRadius: CGFloat {
    get {
      return layer.cornerRadius
    }
    set {
      layer.masksToBounds = true
      layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
    }
  }

}
