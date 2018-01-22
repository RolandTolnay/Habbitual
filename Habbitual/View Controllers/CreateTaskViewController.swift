//
//  CreateTaskViewController.swift
//  Quable Productivity
//
//  Created by Roland Tolnay on 03/01/2018.
//  Copyright © 2018 Roland Tolnay. All rights reserved.
//

import Foundation
import UIKit

class CreateTaskViewController: UIViewController {
  
  @IBOutlet weak var frequencyScrollView: UIScrollView!
  @IBOutlet weak var descriptionTextField: UITextField!
  @IBOutlet weak var leftArrowImageView: UIImageView!
  @IBOutlet weak var rightArrowImageView: UIImageView!
  
  private let frequencyDataSource: [Frequency] = [.daily, .fewDays, .weekly, .sometime, .abstinance]
  private var selectedFrequencyIndex: Int {
    let pageWidth = frequencyScrollView.frame.width
    return Int(floor((frequencyScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupFrequencyScrollView()
    descriptionTextField.becomeFirstResponder()
  }
  
  private func setupFrequencyScrollView() {
    let scrollViewWidth = frequencyScrollView.frame.width
    let scrollViewHeight = frequencyScrollView.frame.height
    frequencyScrollView.frame = CGRect(x: frequencyScrollView.frame.origin.x,
                                       y: frequencyScrollView.frame.origin.y,
                                       width: scrollViewWidth,
                                       height: scrollViewHeight)
    
    for i in 0..<frequencyDataSource.count {
      let label = UILabel(frame: CGRect(x: CGFloat(i) * scrollViewWidth,
                                              y: 22, // distance to top of scrollview
                                              width: scrollViewWidth,
                                              height: 44))
      label.text = frequencyDataSource[i].stringValue
      label.textAlignment = .center
      label.font = UIFont(name: "Optima", size: 18)
      
      frequencyScrollView.addSubview(label)
    }
    
    frequencyScrollView.contentSize = CGSize(width: scrollViewWidth * CGFloat(frequencyDataSource.count),
                                             height: scrollViewHeight)
    frequencyScrollView.delegate = self
    leftArrowImageView.isHidden = true
  }
  
  @IBAction func onLeftArrowTapped(_ sender: UITapGestureRecognizer) {
    guard selectedFrequencyIndex > 0 else { return }
    
    let pageToShow = selectedFrequencyIndex - 1
    scrollToFrequency(page: pageToShow)
  }
  
  @IBAction func onRightArrowTapped(_ sender: Any) {
    guard selectedFrequencyIndex < frequencyDataSource.count - 1 else { return }
    
    let pageToShow = selectedFrequencyIndex + 1
    scrollToFrequency(page: pageToShow)
  }
  
  private func scrollToFrequency(page: Int) {
    let offset = CGPoint(x: frequencyScrollView.frame.width * CGFloat(page), y: 0.0)
    frequencyScrollView.setContentOffset(offset, animated: true)
  }
  
  @IBAction func onCreateTapped(_ sender: UIButton) {
    if let description = descriptionTextField.text, !description.isEmpty {
      let frequency = frequencyDataSource[selectedFrequencyIndex]
      mainStore.dispatch(
        CreateTaskAction(description: description, frequency: frequency)
      )
      dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func onCancelTapped(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
}

extension CreateTaskViewController: UIScrollViewDelegate {
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    displayFrequencyArrows()
  }
  
  func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
    displayFrequencyArrows()
  }
  
  fileprivate func displayFrequencyArrows() {
    leftArrowImageView.isHidden = selectedFrequencyIndex == 0
    rightArrowImageView.isHidden = selectedFrequencyIndex == frequencyDataSource.count - 1
  }
}


