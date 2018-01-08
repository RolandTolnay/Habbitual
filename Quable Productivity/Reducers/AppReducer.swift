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

  switch action {
    case let createAction as CreateTaskAction:
      let task = Task(name: createAction.description, frequency: createAction.frequency)
      if !state.tasks.contains(task) {
        state.tasks.append(task)
        state.todaysTasks = generateTodaysTasks(from: state.tasks)
      }
    case let completeAction as CompleteTaskAction:
        state = completeTaskReducer(action: completeAction, state: state)
    case _ as UpdateTodaysTasksAction:
      state = updateTasksReducer(state: state)
    case let deleteAction as DeleteTaskAction:
      state = deleteTaskReducer(action: deleteAction, state: state)
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

  let todaysTasks = dailyTasks + fewDaysTasks + weeklyTasks + otherTasks
  return todaysTasks.sorted()
}

private func completeTaskReducer(action: CompleteTaskAction, state: AppState) -> AppState {
  var state = state
  
  for i in 0..<state.tasks.count {
    if state.tasks[i] == action.task {
      state.tasks[i].status = .completed
      state.tasks[i].modifiedAt = Date()
    }
  }
  state.todaysTasks = generateTodaysTasks(from: state.tasks)
  state.history.append(action.task)
  
  return state
}

private func deleteTaskReducer(action: DeleteTaskAction, state: AppState) -> AppState {
  var state = state
  
  for i in 0..<state.tasks.count {
    if state.tasks[i] == action.task {
      state.tasks.remove(at: i)
      break
    }
  }
  state.todaysTasks = generateTodaysTasks(from: state.tasks)
  
  return state
}

private func updateTasksReducer(state: AppState) -> AppState {
  var state = state
  
  for i in 0..<state.tasks.count {
    let task = state.tasks[i]
    if task.status == .completed && task.createdAt.hasDayPassed() {
      state.tasks[i].status = .pending
    }
  }
  state.todaysTasks = generateTodaysTasks(from: state.tasks)
  
  return state
}
