//
//  AppDelegate.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import UIKit
import ReSwift

let mainStore = Store<AppState>(
  reducer: appReducer,
  state: unarchiveState()
)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    archiveState(mainStore.state)
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    mainStore.dispatch(
      UpdateTodaysTasksAction()
    )
  }

  func applicationWillTerminate(_ application: UIApplication) {
    archiveState(mainStore.state)
  }
}

