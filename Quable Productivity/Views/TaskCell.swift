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
  @IBOutlet weak var labelToTopConstraint: NSLayoutConstraint!
  @IBOutlet weak var labelToBottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var textStrikethrough: UIView!
  
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: nil)
  }
  
  static var reuseIdentifier: String {
    return String(describing: self)
  }
  
  func setupWith(description: String, frequency: Frequency, status: TaskStatus = .history) {
    if status == .completed {
      self.backgroundColor = UIColor.flatGreenDark
      descriptionLabel.font = UIFont(name: descriptionLabel.font.fontName, size: 16)
      textStrikethrough.isHidden = false
      labelToTopConstraint.constant = 5
      labelToBottomConstraint.constant = 5
    } else {
      textStrikethrough.isHidden = true
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
      if status == .pending {
        labelToTopConstraint.constant = 19.5
        labelToBottomConstraint.constant = 19.5
        descriptionLabel.font = UIFont(name: descriptionLabel.font.fontName, size: 24)
      } else if status == .history {
        labelToTopConstraint.constant = 12
        labelToBottomConstraint.constant = 12
        descriptionLabel.font = UIFont(name: descriptionLabel.font.fontName, size: 20)
      }
    }
    
    descriptionLabel.text = description
  }
}
