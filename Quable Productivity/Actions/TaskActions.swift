//
//  TaskActions.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import Foundation
import ReSwift

struct CreateTaskAction: Action {
  
  var description: String
  var frequency: Frequency
}

struct CompleteTaskAction: Action {
  
  var task: Task
}

struct UpdateTodaysTasksAction: Action { }
