//
//  State.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType, Codable {
  
  var tasks: [Task]
  
  var todaysTasks: [Task]
  var history: [Task]
  
  init() {
    self.tasks = [Task]()
    
    self.todaysTasks = [Task]()
    self.history = [Task]()
  }
}

// MARK: -
// MARK: Archiving & Unarchiving
// --------------------
private let appStateKey = "appStateKey"

func archiveState(_ state: AppState) {
  
  let encoder = JSONEncoder()
  if let encoded = try? encoder.encode(state) {
    UserDefaults.standard.set(encoded, forKey: appStateKey)
    UserDefaults.standard.synchronize()
    print("Successfully saved state")
  } else {
    print("Failed to encode and save state")
  }
}

func unarchiveState() -> AppState? {
  
  let decoder = JSONDecoder()
  guard let stateData = UserDefaults.standard.data(forKey: appStateKey),
    let appState = try? decoder.decode(AppState.self, from: stateData) else {
    print("No archive found")
    return nil
  }
  
  print("Found saved state")
  return appState
}
