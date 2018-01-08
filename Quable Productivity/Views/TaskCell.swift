//
//  TaskCell.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import UIKit
import ChameleonFramework

class TaskCell: UITableViewCell {
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: nil)
  }
  
  static var reuseIdentifier: String {
    return String(describing: self)
  }
  
  func setupWith(description: String, frequency: Frequency, status: TaskStatus = .pending) {
    if status == .completed {
       self.backgroundColor = UIColor.flatGreenDark
    } else {
      switch frequency {
        case .daily:
          self.backgroundColor = UIColor.flatOrange
        case .fewDays:
          self.backgroundColor = UIColor.flatYellowDark
        case .weekly:
          self.backgroundColor = UIColor.flatSandDark
        case .sometime:
          self.backgroundColor = UIColor.flatWhite
        case .abstinance:
          self.backgroundColor = UIColor.flatWatermelon
      }
    }
    
    descriptionLabel.text = description
  }
}
