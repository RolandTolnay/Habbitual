//
//  SecondViewController.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import UIKit
import ReSwift

class HistoryViewController: UIViewController, StoreSubscriber {

  fileprivate var taskSections = [TaskSection]()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupTableView()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    mainStore.subscribe(self)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    mainStore.unsubscribe(self)
  }
  
  func newState(state: AppState) {
    taskSections = sectionsFrom(tasks: state.history)
    if taskSections.isEmpty {
      tableView.isHidden = true
    } else {
      tableView.isHidden = false
      tableView.reloadData()
    }
  }

  private func setupTableView() {
    tableView.dataSource = self
    tableView.register(TaskCell.nib, forCellReuseIdentifier: TaskCell.reuseIdentifier)
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 90
  }
  
  private func sectionsFrom(tasks: [Task]) -> [TaskSection] {
    var sections = [TaskSection]()
    
    for task in tasks {
      guard let modifiedAt = task.modifiedAt else { continue }
      
      var sectionExists = false
      for i in 0..<sections.count {
        if sections[i].date == modifiedAt.startOfDay {
          sections[i].tasks.append(task)
          sectionExists = true
        }
      }
      if !sectionExists {
        let section = TaskSection(date: modifiedAt.startOfDay, tasks: [task])
        sections.append(section)
      }
    }
    for i in 0..<sections.count {
      sections[i].tasks.sort()
    }
    
    return sections.sorted()
  }
}

// MARK: -
// MARK: UITableViewDataSource
// --------------------
extension HistoryViewController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return taskSections.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return taskSections[section].tasks.count
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd MMM"
    
    return formatter.string(from: taskSections[section].date)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as! TaskCell
    let task = taskSections[indexPath.section].tasks[indexPath.row]
    
    cell.setupWith(description: task.name, frequency: task.frequency)
    
    return cell
  }
}

struct TaskSection: Equatable, Comparable {
  
  var date: Date
  var tasks: [Task]
  
  static func ==(lhs: TaskSection, rhs: TaskSection) -> Bool {
    return lhs.date == rhs.date
  }
  
  static func <(lhs: TaskSection, rhs: TaskSection) -> Bool {
    return lhs.date < rhs.date
  }
}

