//
//  CreateTaskViewController.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import Foundation
import UIKit

class CreateTaskViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
  
  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var frequencyPickerView: UIPickerView!
  
  private let frequencyDataSource: [Frequency] = [.daily, .fewDays, .weekly, .sometime, .abstinance]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
  
  @IBAction func onCreateTapped(_ sender: UIButton) {
    if let description = descriptionTextField.text {
      let frequency = frequencyDataSource[frequencyPickerView.selectedRow(inComponent: 0)]
      mainStore.dispatch(
        CreateTaskAction(description: description, frequency: frequency)
      )
      dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func onCancelTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  // MARK:- UIPickerViewDataSource
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return frequencyDataSource.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return frequencyDataSource[row].toString()
  }
}


