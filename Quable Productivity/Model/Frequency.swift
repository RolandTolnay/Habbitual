//
//  Frequency.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import Foundation

enum Frequency {
  
  case daily
  case fewDays
  case weekly
  case sometime
  case abstinance
  
  func toString() -> String {
    switch self {
      case .daily:
        return "Every day"
      case .fewDays:
        return "Every few days"
      case .weekly:
        return "Weekly"
      case .sometime:
        return "Sometime"
      case .abstinance:
        return "Abstinance chain"
    }
  }
}
