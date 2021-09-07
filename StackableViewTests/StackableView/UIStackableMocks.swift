//
//  UIStackableMocks.swift
//  StackableViewTests
//
//  Created by Avinash Gautam on 22/06/21.
//

import UIKit
@testable import StackableView

enum UIStackedableMocks {

  final class SampleStackableItem: UIViewController, UIStackable {
    var stackableConfiguration: UIStackableConfiguration = DefaultStackableItemConfiguration()

    var stackController: UIStackableWeakBox?

    private(set) var willPresentItem: UIStackable?
    func stackableController(_ controller: UIStackableController,
                             willPresent item: UIStackable) {
      willPresentItem = item
    }

    private(set) var willDismissItem: UIStackable?
    func stackableController(_ controller: UIStackableController,
                             willDismiss item: UIStackable) {
      willDismissItem = item
    }

    private(set) var updatedState: UIStackableState?
    private(set) var didUpdateStateItem: UIStackable?
    func stackableController(_ controller: UIStackableController, didUpdateState state: UIStackableState, forItem item: UIStackable) {
      updatedState = state
      didUpdateStateItem = item
    }
  }

}
