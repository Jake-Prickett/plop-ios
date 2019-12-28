//
//  PLOPSpec.swift
//  PLOPTests
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

import XCTest

@testable import PLOP

final class PLOPTests: XCTestCase {
    var rootViewController: UIViewController!
    var plopNavigationController: UINavigationController!
    var plopViewController: PLOPViewController!

    override func setUp() {
        super.setUp()
        rootViewController = UIViewController()
        PLOP.showPanel()
        plopNavigationController = PLOP.plopNavigationController
        plopViewController = plopNavigationController.topViewController as? PLOPViewController
    }

    override func tearDown() {
        super.tearDown()
        PLOP.removeAllComponents()
        PLOP.hidePanel()
    }

    func testShowPanel() {
        XCTAssertNotNil(plopViewController)
    }

    func testDisplayingAddedComponent() {
        let buttonComponent = ButtonPLOPComponent(title: "Test") { _ in }
        PLOP.add(component: buttonComponent)
        XCTAssertEqual(plopViewController.tableView.numberOfRows(inSection: 0), 1)
    }

    func testDisplayingMultipleAddedComponents() {
        let buttonComponent = ButtonPLOPComponent(title: "Test") { _ in }
        let switchComponent = SwitchPLOPComponent(title: "Test 2") { _ in }
        PLOP.add(components: [buttonComponent, switchComponent])
        XCTAssertEqual(plopViewController.tableView.numberOfRows(inSection: 0), 2)
    }

    func testInsertComponent() {
        let buttonComponent = ButtonPLOPComponent(title: "Test") { _ in }
        let switchComponent = SwitchPLOPComponent(title: "Test 2") { _ in }
        PLOP.add(components: [buttonComponent, switchComponent])

        let switchComponent2 = SwitchPLOPComponent(title: "Test 1") { _ in }
        PLOP.insert(component: switchComponent2, atIndexPath: IndexPath(row: 0, section: 0))

        plopViewController.view.setNeedsLayout()
        plopViewController.view.layoutIfNeeded()

        guard let insertedCell = plopViewController
            .tableView
            .cellForRow(at: IndexPath(row: 0, section: 0)) as? PLOPCell else {
                XCTFail("Unable to locate cell for row at index path")
                return
        }
        XCTAssertEqual(insertedCell.titleLabel.text, switchComponent2.title)
    }

    func testRemoveComponent() {
        let buttonComponent = ButtonPLOPComponent(title: "Test") { _ in }
        PLOP.add(component: buttonComponent)
        XCTAssertEqual(plopViewController.tableView.numberOfRows(inSection: 0), 1)
        PLOP.remove(component: buttonComponent)
        XCTAssertEqual(plopViewController.tableView.numberOfRows(inSection: 0), 0)
    }

    func testRemoveComponentAtIndexPath() {
        let buttonComponent = ButtonPLOPComponent(title: "Test") { _ in }
        PLOP.add(component: buttonComponent)
        XCTAssertEqual(plopViewController.tableView.numberOfRows(inSection: 0), 1)
        PLOP.removeComponent(atIndexPath: IndexPath(row: 0, section: 0))
        XCTAssertEqual(plopViewController.tableView.numberOfRows(inSection: 0), 0)
    }

    func testRemoveAllComponents() {
        let buttonComponent = ButtonPLOPComponent(title: "Test") { _ in }
        let switchComponent = SwitchPLOPComponent(title: "Test 2") { _ in }
        PLOP.add(components: [buttonComponent, switchComponent])
        XCTAssertEqual(plopViewController.tableView.numberOfRows(inSection: 0), 2)
        PLOP.removeAllComponents()
        XCTAssertEqual(plopViewController.tableView.numberOfRows(inSection: 0), 0)
    }

    func testAddSection() {
        let section = SectionPLOPComponent(title: "Test1")
        PLOP.add(section: section)
        XCTAssertEqual(plopViewController.tableView.numberOfSections, 2)
        let dataSource = plopViewController.tableView.dataSource!
        XCTAssertEqual(dataSource.tableView!(plopViewController.tableView, titleForHeaderInSection: 1), "Test1")
    }

    func testRemoveSection() {
        let section = SectionPLOPComponent(title: "Test1")
        PLOP.add(section: section)
        XCTAssertEqual(plopViewController.tableView.numberOfSections, 2)
        PLOP.remove(section: section)
        XCTAssertEqual(plopViewController.tableView.numberOfSections, 1)
        let dataSource = plopViewController.tableView.dataSource!
        XCTAssertNil(dataSource.tableView!(plopViewController.tableView, titleForHeaderInSection: 0))
    }

    func testRemoveSectionAtIndex() {
        let section = SectionPLOPComponent(title: "Test1")
        PLOP.add(section: section)
        XCTAssertEqual(plopViewController.tableView.numberOfSections, 2)
        PLOP.removeSection(atIndex: 1)
        XCTAssertEqual(plopViewController.tableView.numberOfSections, 1)
        let dataSource = plopViewController.tableView.dataSource!
        XCTAssertNil(dataSource.tableView!(plopViewController.tableView, titleForHeaderInSection: 0))
    }

    func testEnablingShakeGesture() {
        XCTAssertFalse(rootViewController.canBecomeFirstResponder)
        PLOP.enableShakeToLaunchPanel()
        XCTAssertTrue(rootViewController.canBecomeFirstResponder)
        PLOP.disableShakeToLaunchPanel()
        XCTAssertFalse(rootViewController.canBecomeFirstResponder)
    }
}
