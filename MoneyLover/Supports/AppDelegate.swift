//
//  AppDelegate.swift
//  MoneyLover
//
//  Created by xhieu21 on 03/03/2023.
//

import UIKit
import SwifterSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    playApp()
    return true
  }

  private func playApp() {
		if UserDefaults.standard.isNotFirstLaunch {
			window?.rootViewController = TabViewController()
		} else {
			window?.rootViewController = IntroductionViewController()
			prepareForFirstLaunch()
		}
  }

	private func prepareForFirstLaunch() {

	}

}


