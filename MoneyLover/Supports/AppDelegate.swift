//
//  AppDelegate.swift
//  MoneyLover
//
//  Created by xhieu21 on 03/03/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    playApp()
    return true
  }

  func playApp() {
    if true {
      window?.rootViewController = TabViewController()
    } else {
      window?.rootViewController = IntroductionViewController()
    }
  }

}


