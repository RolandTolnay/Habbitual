//
//  State.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import Foundation
import ReSwift

struct AppState: StateType {
  
  var tasks: [Task]
  
  var todaysTasks: [Task]
  var history: [Task]
  
  init() {
    self.tasks = [Task]()
    
    self.todaysTasks = [Task]()
    self.history = [Task]()
  }
}
