//
//  FirstViewController.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import UIKit
import ReSwift

class TodayViewController: UIViewController, StoreSubscriber {

  fileprivate var tasks = [Task]()
  
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
    tasks = state.todaysTasks
    tableView.reloadData()
  }
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(TaskCell.nib, forCellReuseIdentifier: TaskCell.reuseIdentifier)
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 90
  }
}

// MARK: -
// MARK: UITableViewDataSource
// --------------------
extension TodayViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tasks.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as! TaskCell
    let task = tasks[indexPath.row]
    
    cell.setupWith(description: task.name, frequency: task.frequency, status: task.status)
    
    return cell
  }
}

// MARK: -
// MARK: UITableViewDelegate
// --------------------
extension TodayViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let task = tasks[indexPath.row]
    
    if (task.status == .pending) {
      mainStore.dispatch(
        CompleteTaskAction(task: task)
      )
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == .delete) {
      mainStore.dispatch(
        DeleteTaskAction(task: tasks[indexPath.row])
      )
    }
  }
}
