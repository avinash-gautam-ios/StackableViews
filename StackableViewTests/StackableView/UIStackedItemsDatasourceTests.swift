//
//  UIStackedItemsDatasourceTests.swift
//  StackableViewTests
//
//  Created by Avinash Gautam on 22/06/21.
//

import XCTest
@testable import StackableView

class UIStackedItemsDatasourceTests: XCTestCase {

  var datasource: UIStackedItemsDatasource!

  override func setUp() {
    super.setUp()
    datasource = UIStackedItemsDatasource(maxLimit: 3)
  }

  override func tearDown() {
    super.tearDown()
    datasource = nil
  }

  func testRootItem() {
    /// when
    let item = UIStackedableMocks.SampleStackableItem()
    try? datasource.push(item)

    /// then
    if let root = datasource.rootItem {
      XCTAssertEqual(item, root)
    } else {
      XCTFail("failure: datasource does not contain root element")
    }
  }

  func testTopItem() {
    /// given
    let item1 = UIStackedableMocks.SampleStackableItem()
    let item2 = UIStackedableMocks.SampleStackableItem()

    /// when
    try? datasource.push(item1)
    try? datasource.push(item2)

    /// then
    if let top = datasource.topItem {
      XCTAssertEqual(item2, top)
    } else {
      XCTFail("failure: datasource top element was wrong")
    }
  }

  func testMaxLimitReached() {
    /// given
    [UIStackedableMocks.SampleStackableItem(),
     UIStackedableMocks.SampleStackableItem(),
     UIStackedableMocks.SampleStackableItem()].forEach { item in
      try? datasource.push(item)
     }

    let item = UIStackedableMocks.SampleStackableItem()
    do {
      /// when
      try datasource.push(item)

      /// then
      XCTFail("failure: datasource inserted item more than limit")
    } catch { }
  }

  func testAllItems() {
    /// given
    let items = [UIStackedableMocks.SampleStackableItem(),
                 UIStackedableMocks.SampleStackableItem(),
                 UIStackedableMocks.SampleStackableItem()]
    items.forEach { item in
      /// when
      try? datasource.push(item)
    }

    /// then
    XCTAssertEqual(items.count, datasource.allItems.count)
  }

  func testIsEmpty() {
    /// then
    XCTAssertEqual(true, datasource.isEmpty)
    let item = UIStackedableMocks.SampleStackableItem()

    /// when
    try? datasource.push(item)

    /// then
    XCTAssertEqual(false, datasource.isEmpty)
  }

  func testCanPop() {
    /// given
    [UIStackedableMocks.SampleStackableItem(),
     UIStackedableMocks.SampleStackableItem()]
      .forEach { try? datasource.push($0) }

    /// then
    XCTAssertTrue(datasource.canPop)

    /// when
    _ = try? datasource.pop()

    /// then
    XCTAssertFalse(datasource.canPop)
  }

  func testCanPush() {
    /// given
    [UIStackedableMocks.SampleStackableItem(),
     UIStackedableMocks.SampleStackableItem()]
      .forEach { try? datasource.push($0) }

    /// then
    XCTAssertTrue(datasource.canPush)

    /// when
    let item = UIStackedableMocks.SampleStackableItem()
    try? datasource.push(item)

    /// then
    XCTAssertFalse(datasource.canPush)
  }

  func testPopToRootWithItems() {
    /// given
    [UIStackedableMocks.SampleStackableItem(),
     UIStackedableMocks.SampleStackableItem(),
     UIStackedableMocks.SampleStackableItem()]
      .forEach{ try? datasource.push($0) }

    /// when
    _ = try? datasource.popToRoot()

    /// then
    XCTAssertEqual(datasource.allItems.count, 1)
    XCTAssertFalse(datasource.isEmpty)
  }

  func testPopToRootWithoutItems() {
    /// when
    do {
      try datasource.popToRoot()

      /// then
      XCTFail("failure: no items to pop, datasource still succeded")
    } catch { }
  }
}

