//
//  AppReducer.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import Foundation
import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
  var state = state ?? AppState()
  
  print("appReducer called")
  switch action {
    case let createAction as CreateTaskAction:
      let task = Task(name: createAction.description, frequency: createAction.frequency)
      state.tasks.append(task)
      state.todaysTasks = generateTodaysTasks(from: state.tasks)
    default:
      break
  }
  
  return state
}

private func generateTodaysTasks(from tasks: [Task]) -> [Task] {
  var dailyTasks = [Task]()
  var fewDaysTasks = [Task]()
  var weeklyTasks = [Task]()
  var otherTasks = [Task]()
  
  for task in tasks {
    switch task.frequency {
      case .daily:
        dailyTasks.append(task)
      case .fewDays:
        fewDaysTasks.append(task)
      case .weekly:
        weeklyTasks.append(task)
      case .sometime:
        otherTasks.append(task)
      case .abstinance:
        otherTasks.append(task)
    }
  }

  return dailyTasks + fewDaysTasks + weeklyTasks + otherTasks
}
