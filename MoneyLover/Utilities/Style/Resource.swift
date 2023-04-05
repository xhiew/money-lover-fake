//
//  Resource.swift
//  MoneyLover
//
//  Created by xhieu21 on 14/03/2023.
//

import UIKit

public class Resource {

  public class DateTitle {
    public static let nextMonth = "Tháng sau"
    public static let lastMonth = "Tháng trước"
    public static let thisMonth = "Tháng này"
    public static let nextWeek = "Tuần sau"
    public static let lastWeek = "Tuần trước"
    public static let thisWeek = "Tuần này"
  }

  public class Image {

    public static let openEyes = UIImage(named: "ic_show_password")
    public static let closeEyes = UIImage(named: "ic_hide_password")

    public class OnBoarding {
      public static let paymentSuccessImg: UIImage? = UIImage(named: "img_introduce3")
      public static let waveBackgroundImg: UIImage? = UIImage(named: "Wave")
      public static let protectImg: UIImage? = UIImage(named: "img_introduce2")
      public static let categoryImg1: UIImage? = UIImage(named: "ic_home_a3")
      public static let categoryImg2: UIImage? = UIImage(named: "ic_home_a1")
      public static let categoryImg3: UIImage? = UIImage(named: "ic_home_a2")
      public static let categoryImg4: UIImage? = UIImage(named: "ic_home_a4")
    }

    public class TabBarIcon {
      public static let homeItemImg: UIImage? = UIImage(named: "ic_home_page")
      public static let walletImg: UIImage? = UIImage(named: "ic_wallet2")
      public static let addImg: UIImage? = UIImage(named: "add_green")
    }

  }

  public class Title {

    public static var appVersion: String? {
      guard let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return "" }
      return "Phiên bản \(version)"
    }

    public static let vnd = "₫"
    public static let passwordText = "********"

    class Onboarding {
      public static let appName = "MoneyLover"
      public static let categoryTitle1 = "Giảm các khoản chi không cần thiết"
      public static let categoryTitle2 = "Tiết kiệm đều đặn hàng tháng"
      public static let categoryTitle3 = "Quản lý tất cả ở một nơi"
      public static let categoryTitle4 = "Bảo mật an toàn"
      public static let mainTitlePage1 = "Quản lý tài chính hiệu quả với MoneyLover"
      public static let mainTitlePage2 = "Cắt giảm những chi phí không cần thiết"
      public static let mainTitlePage3 = "Đảm bảo thông tin của bạn luôn được bảo mật"
    }

    class Home {
      public static let notiButton1 = "Nhận thông báo"
      public static let notiButton2 = "Đã bật nhận thông báo"
      public static let expenseReport = "Báo cáo chi tiêu"
      public static let recentTransaction = "Giao dịch gần đây"
      public static let personalPlan = "Kế hoạch cá nhân"
      public static let sales = "Khuyến mãi"
    }

  }

}
