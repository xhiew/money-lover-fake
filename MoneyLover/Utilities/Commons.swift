//
//  Commons.swift
//  MoneyLover
//
//  Created by xhieu21 on 21/03/2023.
//

import UIKit

public class Commons {

  public static var shared = Commons()
  private init() {}

  let numberOfRowsInSection = 1

  func animateButton(viewToAnimate: UIView) {
    UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn) {
      viewToAnimate.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
    } completion: { (_) in
      UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .curveEaseIn) {
        viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
      }
    }
  }

}
