//
//  Date.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 04/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import Foundation

extension Date {
  
  func hasDayPassed() -> Bool {
    let calendar = Calendar.current
    let startOfNow = calendar.startOfDay(for: Date())
    let startOfSelf = calendar.startOfDay(for: self)
    let components = calendar.dateComponents([.day], from: startOfNow, to: startOfSelf)

    return components.day! < 0
  }
}
