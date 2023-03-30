//
//  Category.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/03/2023.
//

import UIKit

struct Category {
  let image: UIImage?
  let title: String?
}

struct CategoryManager {
  let dataSource: [Category] = [
    Category(image: Resource.Image.OnBoarding.categoryImg1, title: Resource.Title.Onboarding.categoryTitle1),
    Category(image: Resource.Image.OnBoarding.categoryImg2, title: Resource.Title.Onboarding.categoryTitle2),
    Category(image: Resource.Image.OnBoarding.categoryImg3, title: Resource.Title.Onboarding.categoryTitle3),
    Category(image: Resource.Image.OnBoarding.categoryImg4, title: Resource.Title.Onboarding.categoryTitle4),
  ]

}
