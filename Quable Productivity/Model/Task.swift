//
//  Task.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import Foundation

struct Task {
  
  var name: String
  var frequency: Frequency
  var status: TaskStatus
  
  var createdAt: Date
  
  init(name: String, frequency: Frequency, status: TaskStatus = .pending, createdAt: Date = Date()) {
    self.name = name
    self.frequency = frequency
    
    self.status = status
    self.createdAt = createdAt
  }
}


