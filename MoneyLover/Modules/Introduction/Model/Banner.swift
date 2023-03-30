//
//  Banner.swift
//  MoneyLover
//
//  Created by xhieu21 on 15/03/2023.
//

import UIKit

struct Banner {
  let backgroundImg: UIImage?
  let mainImg: UIImage?
  let title: String?
}

struct BannerManager {
  let itemInSection: [OnBoardingCell] = [.category, .bannerPage, .bannerPage]
  let bannerData: [Banner] = [
    Banner(backgroundImg: Resource.Image.OnBoarding.waveBackgroundImg,
           mainImg: Resource.Image.OnBoarding.paymentSuccessImg,
           title: Resource.Title.Onboarding.mainTitlePage2),
    Banner(backgroundImg: Resource.Image.OnBoarding.waveBackgroundImg,
           mainImg: Resource.Image.OnBoarding.protectImg,
           title: Resource.Title.Onboarding.mainTitlePage3)
  ]

}

enum OnBoardingCell {
  case category
  case bannerPage
}
