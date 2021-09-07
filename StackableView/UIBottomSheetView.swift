//
//  UIBottomSheetView.swift
//  StackableView
//
//  Created by Avinash Gautam on 21/06/21.
//

import UIKit

struct UIBottomSheetConfiguration {
  private enum Constants {
    static let heightOffset: CGFloat = 30
    static let corderRadius: CGFloat = 6
  }

  let maxHeight: CGFloat
  let cornerRadius: CGFloat

  static func `default`() -> UIBottomSheetConfiguration {
    let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
    let calculatedHeight = (keyWindow?.safeAreaInsets.bottom ?? 0) + Constants.heightOffset
    let maxHeight = UIScreen.main.bounds.height - calculatedHeight
    return UIBottomSheetConfiguration(maxHeight: maxHeight,
                                      cornerRadius: Constants.corderRadius)
  }
}

class UIBottomSheetView: UIView {

  private lazy var containerStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.alignment = .fill
    stackView.axis = .vertical
    return stackView
  }()

  private lazy var containerScrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.showsVerticalScrollIndicator = false
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.keyboardDismissMode = .interactive
    return scrollView
  }()

  private let configuration: UIBottomSheetConfiguration
  private let contentView: UIView
  private let estimatedHeight: CGFloat?

  init(contentView: UIView,
       estimatedHeight: CGFloat? = nil,
       configuration: UIBottomSheetConfiguration = UIBottomSheetConfiguration.default()) {
    self.contentView = contentView
    self.configuration = configuration
    self.estimatedHeight = estimatedHeight
    super.init(frame: .zero)
    self.prepareView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func show(in containerView: UIView) {
    containerView.addSubview(self)
    self.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview()
      make.bottom.equalTo(-configuration.maxHeight)
      if let estimatedHeight = self.estimatedHeight,
         estimatedHeight < self.configuration.maxHeight {
        make.height.equalTo(estimatedHeight)
      } else {
        make.height.lessThanOrEqualTo(self.configuration.maxHeight)
      }
    }

    UIView.animate(withDuration: 0.5) {
      self.layoutIfNeeded()
    }

  }

  //MARK: - Private

  private func prepareView() {
    addSubview(containerScrollView)
    containerScrollView.snp.makeConstraints { make in
      make.leading.trailing.top.bottom.equalToSuperview()
    }

    containerScrollView.addSubview(containerStackView)
    containerStackView.snp.makeConstraints { make in
      make.leading.trailing.top.bottom.equalToSuperview()
      make.width.equalToSuperview()
    }
    containerStackView.addSubview(contentView)
  }

}
