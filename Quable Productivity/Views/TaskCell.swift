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
  
  func setupWith(description: String, status: TaskStatus = .pending) {
    switch status {
      case .pending:
        self.backgroundColor = UIColor.flatSand
      case .completed:
        self.backgroundColor = UIColor.flatMintDark
    }
    
    descriptionLabel.text = description
  }
}
