//
//  Default.swift
//  StackableView
//
//  Created by Avinash Gautam on 22/06/21.
//

import UIKit

/// default stackable view style
struct DefaultStackableItemStyle: UIStackableStyle {
  let backgroundColor: UIColor
  let shadowOpacity: Float
  let shadowColor: UIColor
  let shadowRadius: CGFloat
  let shadowSize: CGSize

  init() {
    self.backgroundColor = UIStackableConstants.backgroundColor
    self.shadowColor = UIStackableConstants.shadowColor
    self.shadowOpacity = UIStackableConstants.shadowOpacity
    self.shadowRadius = UIStackableConstants.shadowRadius
    self.shadowSize = UIStackableConstants.shadowSize
  }
}

/// default stackable item configuration
struct DefaultStackableItemConfiguration: UIStackableConfiguration {
  let cornerRadius: CGFloat
  let nextItemHeaderOffset: CGFloat
  let estimatedHeight: UIStackableItemHeightType
  let style: UIStackableStyle
  let openAnimationDuration: TimeInterval
  let closeAnimationDuration: TimeInterval
  let animationDelay: TimeInterval

  init() {
    self.style = DefaultStackableItemStyle()
    self.cornerRadius = 12
    self.nextItemHeaderOffset = 80
    self.estimatedHeight = .height(value: 600)
    self.openAnimationDuration = 0.5
    self.closeAnimationDuration = 0.5
    self.animationDelay = 0
  }
}
