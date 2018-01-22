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
    // CRUD
    case let createAction as CreateTaskAction:
      let task = Task(name: createAction.description, frequency: createAction.frequency)
      if !state.tasks.contains(task) {
        state.tasks.append(task)
        state.todaysTasks = state.tasks.sorted()
      }
    case let deleteAction as DeleteTaskAction:
      state = deleteTaskReducer(action: deleteAction, state: state)
    case _ as UpdateTodaysTasksAction:
      state = updateTasksReducer(state: state)
    
    // Task status
    case let changeTaskStatusAction as ChangeTaskStatusAction:
      state = changeTaskStatusReducer(action: changeTaskStatusAction, state: state)
    
    default:
      break
  }
  
  return state
}

private func changeTaskStatusReducer(action: ChangeTaskStatusAction, state: AppState) -> AppState {
  var state = state
  
  for i in 0..<state.tasks.count {
    if state.tasks[i] == action.task {
      if let _ = action as? CompleteTaskAction {
        state.tasks[i].status = .completed
      } else if let _ = action as? UncompleteTaskAction {
        state.tasks[i].status = .pending
      }
      state.tasks[i].modifiedAt = Date()
    }
  }
  state.todaysTasks = state.tasks.sorted()
  
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
  state.todaysTasks = state.tasks.sorted()
  
  return state
}

private func updateTasksReducer(state: AppState) -> AppState {
  var state = state
  
  for i in 0..<state.tasks.count {
    let task = state.tasks[i]
    if task.status == .completed,
      let modifiedAt = task.modifiedAt,
      modifiedAt.hasDayPassed() {
      
      state.history.append(task)
      state.tasks[i].status = .pending
    }
  }
  state.todaysTasks = state.tasks.sorted()
  
  return state
}
