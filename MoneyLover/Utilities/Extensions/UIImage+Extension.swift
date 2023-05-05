//
//  UIImage+Extension.swift
//  MoneyLover
//
//  Created by xhieu21 on 05/05/2023.
//

import UIKit

extension UIImage {
	func resized(to size: CGSize) -> UIImage {
		return UIGraphicsImageRenderer(size: size).image { _ in
			draw(in: CGRect(origin: .zero, size: size))
		}
	}
}
