//
//  BSampleViewController.swift
//  StackableView
//
//  Created by Avinash Gautam on 22/06/21.
//

import UIKit
import SnapKit

class BSampleViewController: UIViewController, UIStackable {

  var stackController: UIStackableWeakBox?

  var stackableConfiguration: UIStackableConfiguration = DefaultStackableItemConfiguration()

  let headerButton = UIButton()

  let bottomButton = UIButton()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.colorFrom(red: 26, green: 28, blue: 41)

    addBottomCTA()
  }

  private func addBottomCTA() {
    bottomButton.setTitle("Show More Options", for: .normal)
    bottomButton.backgroundColor = UIColor.colorFrom(red: 59, green: 71, blue: 155)
    bottomButton.setTitleColor(.white, for: .normal)
    bottomButton.addTarget(self, action: #selector(bottomCTAPressedAction), for: .touchUpInside)
    view.addSubview(bottomButton)
    bottomButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.bottom.equalToSuperview()
      make.height.equalTo(70)
    }
  }

  private func addHeaderCTA() {
    headerButton.setTitle("Header View #2", for: .normal)
    headerButton.backgroundColor = UIColor.colorFrom(red: 26, green: 28, blue: 41)
    headerButton.setTitleColor(.white, for: .normal)
    headerButton.addTarget(self, action: #selector(headerCTAPressedAction), for: .touchUpInside)
    headerButton.alpha = 0.0
    view.addSubview(headerButton)
    headerButton.snp.makeConstraints { make in
      make.top.equalToSuperview()
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(stackableConfiguration.nextItemHeaderOffset)
    }

    UIView.animate(withDuration: stackableConfiguration.openAnimationDuration) {
      self.headerButton.alpha = 1.0
    }
  }

  private func removeHeaderCTA() {
    UIView.animate(withDuration: stackableConfiguration.closeAnimationDuration) {
      self.headerButton.alpha = 0
    } completion: { _ in
      self.headerButton.removeFromSuperview()
    }
  }

  @objc private func bottomCTAPressedAction() {
    let sampleC = CSampleViewController()
    try? stackController?.stack?.push(sampleC)
  }

  @objc private func headerCTAPressedAction() {
    try? stackController?.stack?.popToItem(self)
    removeHeaderCTA()
  }

  func stackableController(_ controller: UIStackableController, didUpdateState state: UIStackableState, forItem item: UIStackable) {
    print("state changed for \(NSStringFromClass(BSampleViewController.self)) to \(state)")
    switch state {
    case .collapsed:
      addHeaderCTA()
    case .expanded:
      headerButton.removeFromSuperview()
    }
  }

}

