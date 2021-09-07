//
//  CSampleViewController.swift
//  StackableView
//
//  Created by Avinash Gautam on 22/06/21.
//
import UIKit
import SnapKit

class CSampleViewController: UIViewController, UIStackable {

  var stackController: UIStackableWeakBox?

  var stackableConfiguration: UIStackableConfiguration = DefaultStackableItemConfiguration()

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor.colorFrom(red: 39, green: 42, blue: 61)

    addCenterText()
  }

  private func addCenterText() {
    let label = UILabel()
    label.text = "No more Options"
    label.textColor = UIColor.colorFrom(red: 137, green: 153, blue: 164)
    view.addSubview(label)
    label.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
    }
  }

  func stackableController(_ controller: UIStackableController, didUpdateState state: UIStackableState, forItem item: UIStackable) {
    print("state changed for \(NSStringFromClass(CSampleViewController.self)) to \(state)")
  }

}
