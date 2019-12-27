//
//  PLOPSpec.swift
//  PLOPTests
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import PLOP

class PLOPSpec: QuickSpec {
    override func spec() {
        describe("PLOPSpec") {
            var rootViewController: UIViewController!
            var plopNavigationController: UINavigationController!
            var plopViewController: PLOPViewController!
            
            beforeEach {
                rootViewController = UIViewController()
                PLOP.showPanel()
                plopNavigationController = PLOP.plopNavigationController
                plopViewController = plopNavigationController.topViewController as? PLOPViewController
            }
            
            afterEach {
                PLOP.removeAllComponents()
                PLOP.hidePanel()
            }
            
            it("should show the panel") {
                expect(plopViewController).to(beAKindOf(PLOPViewController.self))
            }
            
            it("should display an added component") {
                let buttonComponent = ButtonPLOPComponent(title: "Test") { _ in }
                PLOP.add(component: buttonComponent)
                expect(plopViewController.tableView.numberOfRows(inSection: 0)).to(equal(1))
            }
            
            it("should display added components") {
                let buttonComponent = ButtonPLOPComponent(title: "Test") { _ in }
                let switchComponent = SwitchPLOPComponent(title: "Test 2") { _ in }
                PLOP.add(components: [buttonComponent, switchComponent])
                expect(plopViewController.tableView.numberOfRows(inSection: 0)).to(equal(2))
            }
            
            it("should insert components at the correct index path") {
                let buttonComponent = ButtonPLOPComponent(title: "Test") { _ in }
                let switchComponent = SwitchPLOPComponent(title: "Test 2") { _ in }
                PLOP.add(components: [buttonComponent, switchComponent])
                
                let switchComponent2 = SwitchPLOPComponent(title: "Test 1") { _ in }
                PLOP.insert(component: switchComponent2, atIndexPath: IndexPath(row: 0, section: 0))
                
                plopViewController.view.setNeedsLayout()
                plopViewController.view.layoutIfNeeded()
                
                let insertedCell = plopViewController
                                    .tableView
                                    .cellForRow(at: IndexPath(row: 0, section: 0)) as! PLOPCell
                expect(insertedCell.titleLabel.text).to(equal(switchComponent2.title))
            }
            
            it("should remove a component") {
                let buttonComponent = ButtonPLOPComponent(title: "Test") { _ in }
                PLOP.add(component: buttonComponent)
                expect(plopViewController.tableView.numberOfRows(inSection: 0)).to(equal(1))
                PLOP.remove(component: buttonComponent)
                expect(plopViewController.tableView.numberOfRows(inSection: 0)).to(equal(0))
            }
            
            it("should remove a component at index path") {
                let buttonComponent = ButtonPLOPComponent(title: "Test") { _ in }
                PLOP.add(component: buttonComponent)
                expect(plopViewController.tableView.numberOfRows(inSection: 0)).to(equal(1))
                PLOP.removeComponent(atIndexPath: IndexPath(row: 0, section: 0))
                expect(plopViewController.tableView.numberOfRows(inSection: 0)).to(equal(0))
            }
            
            it("should remove all components") {
                let buttonComponent = ButtonPLOPComponent(title: "Test") { _ in }
                let switchComponent = SwitchPLOPComponent(title: "Test 2") { _ in }
                PLOP.add(components: [buttonComponent, switchComponent])
                expect(plopViewController.tableView.numberOfRows(inSection: 0)).to(equal(2))
                PLOP.removeAllComponents()
                expect(plopViewController.tableView.numberOfRows(inSection: 0)).to(equal(0))
            }
            
            it("should display added section") {
                let section = SectionPLOPComponent(title: "Test1")
                PLOP.add(section: section)
                expect(plopViewController.tableView.numberOfSections).to(equal(2))
                let dataSource = plopViewController.tableView.dataSource!
                expect(dataSource.tableView!(plopViewController.tableView, titleForHeaderInSection: 1)).to(equal("Test1"))
            }
            
            it("should insert a section") {
                let section = SectionPLOPComponent(title: "Test1")
                PLOP.insert(section: section, atIndex: 0)
                expect(plopViewController.tableView.numberOfSections).to(equal(2))
                let dataSource = plopViewController.tableView.dataSource!
                expect(dataSource.tableView!(plopViewController.tableView, titleForHeaderInSection: 0)).to(equal("Test1"))
            }
            
            it("should remove a section") {
                let section = SectionPLOPComponent(title: "Test1")
                PLOP.add(section: section)
                expect(plopViewController.tableView.numberOfSections).to(equal(2))
                PLOP.remove(section: section)
                expect(plopViewController.tableView.numberOfSections).to(equal(1))
                let dataSource = plopViewController.tableView.dataSource!
                expect(dataSource.tableView!(plopViewController.tableView, titleForHeaderInSection: 0)).to(beNil())
            }
            
            it("should remove a section at index") {
                let section = SectionPLOPComponent(title: "Test1")
                PLOP.add(section: section)
                expect(plopViewController.tableView.numberOfSections).to(equal(2))
                PLOP.removeSection(atIndex: 1)
                expect(plopViewController.tableView.numberOfSections).to(equal(1))
                let dataSource = plopViewController.tableView.dataSource!
                expect(dataSource.tableView!(plopViewController.tableView, titleForHeaderInSection: 0)).to(beNil())
            }
            
            it("should enable/disable the shake gesture") {
                expect(rootViewController.canBecomeFirstResponder).to(beFalse())
                PLOP.enableShakeToLaunchPanel()
                expect(rootViewController.canBecomeFirstResponder).to(beTrue())
                PLOP.disableShakeToLaunchPanel()
                expect(rootViewController.canBecomeFirstResponder).to(beFalse())
            }
        }
    }
}
