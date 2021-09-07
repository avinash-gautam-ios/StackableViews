//
//  UIStackControllerTests.swift
//  StackableViewTests
//
//  Created by Avinash Gautam on 23/06/21.
//

import XCTest
@testable import StackableView

class UIStackableControllerTests: XCTestCase {

  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  private func prepareSut(rootItem: UIStackable? = nil) -> UIStackableController {
    let controller: UIStackableController
    if let item = rootItem {
      controller = UIStackableController(rootStackItem: item,
                                         configuration: DefaultStackableControllerConfiguration())
    } else {
      controller = UIStackableController(configuration: DefaultStackableControllerConfiguration())
    }
    return controller
  }

  func testPushSameInstanceNotAllowed() {
    /// given
    let item = UIStackedableMocks.SampleStackableItem()
    let controller = prepareSut(rootItem: item)
    do {
      /// when
      try controller.push(item)

      /// then
      XCTFail("failure: able to push the same instance again")
    } catch { }
  }

  func testPushItemCallbacks() {
    /// given
    let item1 = UIStackedableMocks.SampleStackableItem()
    let item2 = UIStackedableMocks.SampleStackableItem()
    let controller = prepareSut(rootItem: item1)
    do {
      /// when
      try controller.push(item2)

      /// new item presentation
      XCTAssertTrue(item2 === item2.willPresentItem)
      /// prev item state
      XCTAssertEqual(item1.updatedState, .collapsed)
    } catch { }
  }

  func testPushMaxLimitReached() {
    /// given
    let controller = prepareSut()
    [UIStackedableMocks.SampleStackableItem(),
     UIStackedableMocks.SampleStackableItem(),
     UIStackedableMocks.SampleStackableItem(),
     UIStackedableMocks.SampleStackableItem()]
      .forEach { try? controller.push($0) }

    do {
      /// when
      let item = UIStackedableMocks.SampleStackableItem()
      try controller.push(item)

      /// then
      XCTFail("failure: able to push even if max limit reached")
    } catch { }
  }

  func testPop() {
    /// given
    let controller = prepareSut()
    let items = [UIStackedableMocks.SampleStackableItem(),
                 UIStackedableMocks.SampleStackableItem()]
    items.forEach { try? controller.push($0) }

    do {
      /// when
      let item = try controller.pop()

      /// then
      XCTAssertTrue(item === items[1])
    } catch { }
  }

  func testPopCannotPopRootItem() {
    /// given
    let controller = prepareSut()
    let items = [UIStackedableMocks.SampleStackableItem()]
    items.forEach { try? controller.push($0) }

    do {
      /// when
      _ = try controller.pop()

      /// then
      XCTFail("failure: able to pop the root item from stack")
    } catch { }
  }

  func testPopToRoot() {
    /// given
    let controller = prepareSut()
    let items = [UIStackedableMocks.SampleStackableItem(),
                 UIStackedableMocks.SampleStackableItem(),
                 UIStackedableMocks.SampleStackableItem()]
    items.forEach { try? controller.push($0) }

    do {
      /// when
      let popedItems = try controller.popToRoot()

      /// then
      XCTAssertEqual(popedItems.count, 2)
      XCTAssertTrue(popedItems.contains(where: { $0 == items[1] }))
      XCTAssertTrue(popedItems.contains(where: { $0 == items[2] }))
    } catch { }
  }

  func testPopToSpecificItem() {
    /// given
    let controller = prepareSut()
    let items = [UIStackedableMocks.SampleStackableItem(),
                 UIStackedableMocks.SampleStackableItem(),
                 UIStackedableMocks.SampleStackableItem(),
                 UIStackedableMocks.SampleStackableItem()]
    items.forEach { try? controller.push($0) }

    do {
      /// when
      let popedItems = try controller.popToItem(items[2])

      /// then
      XCTAssertEqual(popedItems.count, 1)
      XCTAssertTrue(popedItems.contains(where: { $0 == items[3] }))
    } catch { }
  }

}
