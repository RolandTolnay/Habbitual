//
//  TaskCell.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
  
  @IBOutlet weak var descriptionLabel: UILabel!
  
  static var nib: UINib {
    return UINib(nibName: String(describing: self), bundle: nil)
  }
  
  static var reuseIdentifier: String {
    return String(describing: self)
  }
  
  func setupWith(description: String, status: TaskStatus = .pending) {
    descriptionLabel.text = description
  }
}
