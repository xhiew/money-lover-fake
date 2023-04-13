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
		public static let future = "Tương lai"
  }

  public class Image {
    public static let openEyes = UIImage(named: "ic_show_password")
    public static let closeEyes = UIImage(named: "ic_hide_password")
		public static let systemNote = UIImage(systemName: "terminal")
		public static let systemCalendar = UIImage(systemName: "calendar")
		public static let systemError = UIImage(systemName: "exclamationmark.triangle.fill")?.withTintColor(Theme.shared.warningColor, renderingMode: .alwaysOriginal)
		public static let systemSuccess = UIImage(systemName: "checkmark.seal.fill")?.withTintColor(Theme.shared.greenButtonColor, renderingMode: .alwaysOriginal)

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
    public static let privateAmount = "********"
		public static let note = "Ghi chú"
		public static let descriptionIgnoreReport = "Giao dịch của bạn sẽ không nằm trong số liệu phân tích và báo cáo. Bạn vẫn có thể theo dõi giao dịch bị bỏ qua trong lịch sử giao dịch."
		public static let titleIgnoreReport = "Điều gì sẽ xảy ra?"

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

    class TabBarTitle {
      static let home = "Tổng quan"
      static let create = "Tạo giao dịch"
      static let history = "Sổ giao dịch"
    }

    class Home {
      public static let notiButton1 = "Nhận thông báo"
      public static let notiButton2 = "Đã bật nhận thông báo"
      public static let expenseReport = "BÁO CÁO CHI TIÊU"
      public static let recentTransaction = "GIAO DỊCH GẦN ĐÂY"
      public static let personalPlan = "KẾ HOẠCH CÁ NHÂN"
      public static let sales = "KHUYẾN MÃI"
    }

		class CreateTransactionTitle {
			public static let warningTitle = "Oops!"
			public static let warningSubtitle = "Thiếu thông tin"
			public static let successTitle = "Yes!"
			public static let successSubtitle = "Tạo thành công"
		}

		class GroupTypeDescription {
			public static let monthlyExpenses = "Các khoản chi tiêu ưu tiên và đều đặn mỗi tháng."
			public static let essentialExpenses = "Các khoản chi tiêu không thường xuyên nhưng cần thiết."
		}

		class GroupTypeTitle {
			public static let monthlyExpenses = "Chi tiêu hàng tháng"
			public static let essentialExpenses = "Chi tiêu cần thiết"
			public static let entertainment = "Vui - chơi"
			public static let revenue = "Khoản thu"
			public static let groupType = "Phân loại nhóm"
		}

  }

}
