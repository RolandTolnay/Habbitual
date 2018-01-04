//
//  Task.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import Foundation

struct Task: Codable {
  
  var name: String
  var frequency: Frequency
  var status: TaskStatus
  
  var createdAt: Date
  var modifiedAt: Date?
  
  init(name: String, frequency: Frequency, status: TaskStatus = .pending, createdAt: Date = Date()) {
    self.name = name
    self.frequency = frequency
    
    self.status = status
    self.createdAt = createdAt
  }
}

// MARK: -
// MARK: Equatable
// --------------------
extension Task: Equatable { }

func ==(lhs: Task, rhs: Task) -> Bool {
  return lhs.name == rhs.name
}

// MARK: -
// MARK: Comparable
// --------------------
extension Task: Comparable {
  
  static func < (lhs: Task, rhs: Task) -> Bool {
    if (lhs.status == rhs.status) {
      guard let lhsModified = lhs.modifiedAt else { return false }
      guard let rhsModified = rhs.modifiedAt else { return true }
      
      return lhsModified > rhsModified
    }
    
    return lhs.status == .pending && rhs.status == .completed
  }
}
