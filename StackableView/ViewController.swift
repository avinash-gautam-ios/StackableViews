//
//  ViewController.swift
//  StackableView
//
//  Created by Avinash Gautam on 21/06/21.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    addDemoButton()
  }

  private func addDemoButton() {
    let button = UIButton()
    view.addSubview(button)
    button.snp.makeConstraints { make in
      make.centerX.centerY.equalToSuperview()
    }
    button.setTitle("Show Demo", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.addTarget(self, action: #selector(demoButtonPressedAction), for: .touchUpInside)
  }

  @objc func demoButtonPressedAction() {
    let rootStackItem = ASampleViewController()
    let stackController = UIStackableController(rootStackItem: rootStackItem,
                                                configuration: DefaultStackableControllerConfiguration())
    self.present(stackController, animated: true, completion: nil)
  }

}
