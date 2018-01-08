//
//  TaskActions.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import Foundation
import ReSwift

// MARK: -
// MARK: CRUD
// --------------------
struct CreateTaskAction: Action {
  
  var description: String
  var frequency: Frequency
}

struct DeleteTaskAction: Action {
  
  var task: Task
}

struct UpdateTodaysTasksAction: Action { }

// MARK: -
// MARK: Task status
// --------------------
protocol ChangeTaskStatusAction: Action {
  
  var task: Task { get set }
}

struct CompleteTaskAction: ChangeTaskStatusAction {
  
  var task: Task
}

struct UncompleteTaskAction: ChangeTaskStatusAction {
  
  var task: Task
}
