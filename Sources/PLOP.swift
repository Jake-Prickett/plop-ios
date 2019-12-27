//
//  PLOP.swift
//  PLOP
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

import Foundation

public protocol PLOPComponent: AnyObject {
    var title: String { get }
    var inputView: UIView? { get }
}

/**
 Programmable Live Objects Panel
 
 Generate a hidden panel to access prototypes and control debug settings
 */
public final class PLOP: NSObject {

    private static let instance = PLOP()
    static var isShakeEnabled = false

    private var sectionComponents: [SectionPLOPComponent] = [SectionPLOPComponent()] {
        didSet {
            rootPLOPController?.reload()
        }
    }

    private var navigationController: UINavigationController?
    private var rootPLOPController: PLOPViewController?

    /**
     Accessor for the root navigation controller of the panel
     */
    public static var plopNavigationController: UINavigationController? {
        return instance.navigationController
    }


    /**
     Adds a PLOP component to the panel
     - parameter component: The `PLOPComponent` to add
     */
    public class func add(component: PLOPComponent) {
        guard let mainSection = instance.sectionComponents.first else {
            return
        }

        mainSection.components.append(component)
        instance.rootPLOPController?.reload()
    }

    /**
     Adds a PLOP Section component to the panel
     - parameter component: The `SectionPLOPComponent` to add
     */
    public class func add(section: SectionPLOPComponent) {
        instance.sectionComponents.append(section)
    }

    /**
     Adds an array of PLOP components to the panel
     - parameter components: An array of `PLOPComponent`s to add
     */
    public class func add(components: [PLOPComponent]) {
        guard let mainSection = instance.sectionComponents.first else {
            return
        }

        mainSection.components.append(contentsOf: components)
        instance.rootPLOPController?.reload()
    }

    /**
     Inserts a PLOP component to the panel at a specific position
      - parameter component: The `PLOPComponent` to insert
      - parameter indexPath: The position in which to insert the component
     */
    public class func insert(component: PLOPComponent, atIndexPath indexPath: IndexPath) {
        let section = instance.sectionComponents[indexPath.section]
        section.components.insert(component, at: indexPath.row)
        instance.rootPLOPController?.reload()
    }

    /**
     Inserts a PLOP component to the panel at a specific position
     - parameter section: The `SectionPLOPComponent` to insert
     - parameter index: The position in which to insert the component
     */
    public class func insert(section: SectionPLOPComponent, atIndex index: Int) {
        instance.sectionComponents.insert(section, at: index)
    }

    /**
     Removes a component from the panel
     - parameter component: The component to remove
     - parameter section: The section in which to remove the component (defaults to 0)
     - note: This compares the component pointers
     to determine which component to remove
     */
    public class func remove(component componentToRemove: PLOPComponent, fromSection section: Int = 0) {
        let sectionComponent = instance.sectionComponents[section]
        var idx = 0
        for component in sectionComponent.components {
            if componentToRemove === component {
                removeComponent(atIndexPath: IndexPath(row: idx, section: section))
                break
            }
            idx += 1
        }
    }

    /**
     Removes a component from the panel
     - parameter indexPath: the indexPath of the component to remove
     */
    public class func removeComponent(atIndexPath indexPath: IndexPath) {
        instance.sectionComponents[indexPath.section].components.remove(at: indexPath.row)
        instance.rootPLOPController?.reload()
    }

    /**
     Removes all components from the panel
     */
    public class func removeAllComponents() {
        instance.sectionComponents.removeAll()
        instance.sectionComponents.append(SectionPLOPComponent())
    }

    /**
     Removes a section from the panel
     - parameter section: The section to remove
     - note: This compares the section component pointers
     to determine which section to remove
     */
    public class func remove(section sectionToRemove: SectionPLOPComponent) {
        var idx = 0
        for section in instance.sectionComponents {
            if sectionToRemove === section {
                removeSection(atIndex: idx)
                break
            }
            idx += 1
        }
    }

    /**
     Removes a section from the panel
     - parameter index: the index of the component to remove
     */
    public class func removeSection(atIndex index: Int) {
        instance.sectionComponents.remove(at: index)
    }

    /**
     Enables the shake gesture to display the panel
     - note: This extends the `canBecomeFirstResponder` property and `motionBegan(...)`
     method on UIViewController in order to work
     */
    public class func enableShakeToLaunchPanel() {
        isShakeEnabled = true
    }

    /**
     Disables the shake gesture to display the panel
     */
    public class func disableShakeToLaunchPanel() {
        isShakeEnabled = false
    }

    /**
     Pushes a ViewController from panel
     - note: This method only works when the panel is displayed
     */
    public class func push(viewController: UIViewController) {
        instance.navigationController?.pushViewController(viewController, animated: true)
    }

    /**
     Presents a ViewController from panel
     - note: This method only works when the panel is displayed
     */
    public class func present(viewController: UIViewController) {
        instance.rootPLOPController?.present(viewController, animated: true, completion: nil)
    }

    /**
     Presents the panel modally over the top most view controller
     */
    public class func showPanel() {
        instance.launchPanel()
    }

    /**
     Dismisses the panel
     */
    public class func hidePanel() {
        instance.dismissPanel()
    }

    public class func reloadPanel() {
        instance.rechargePanel()
    }

    // MARK: - Private Methods

    @objc private func launchPanel() {
        loadControllers()

        guard let topViewController = topViewController(),
            let navController = navigationController,
            topViewController != navController else {
            return
        }

        topViewController.present(navController, animated: true, completion: nil)
    }

    @objc private func dismissPanel() {
        navigationController?.presentingViewController?.dismiss(animated: true) {
            self.navigationController?.viewControllers = []
            self.rootPLOPController = nil
            self.navigationController = nil
        }
    }

    private func rechargePanel() {
        navigationController?.presentingViewController?.dismiss(animated: true) {
            self.navigationController?.viewControllers = []
            self.rootPLOPController = nil
            self.navigationController = nil

            PLOP.instance.launchPanel()
        }
    }

    private func loadControllers() {
        loadPLOPController()
        loadNavController()
    }

    private func loadNavController() {
        guard navigationController == nil, let plopController = rootPLOPController else {
            return
        }

        navigationController = UINavigationController(rootViewController: plopController)
    }

    private func loadPLOPController() {
        if rootPLOPController == nil {
            rootPLOPController = PLOPViewController(dataSource: self, delegate: self)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissPanel))
            doneButton.tintColor = .darkModeBlue
            rootPLOPController?.navigationItem.leftBarButtonItem = doneButton
        }
    }
}

// MARK: - Table View Data Source

extension PLOP: UITableViewDataSource, UITableViewDelegate {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return sectionComponents.count
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionComponents[section].components.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PLOPCell.reuseId, for: indexPath) as? PLOPCell else {
            return UITableViewCell()
        }

        let component = sectionComponents[indexPath.section].components[indexPath.row]
        cell.titleLabel.text = component.title
        if let inputView = component.inputView {
            cell.add(inputView: inputView)
        }

        return cell
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 30
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionComponents[section].title
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: PLOPSectionHeader.reuseId) as? PLOPSectionHeader else { return UIView() }
        header.sectionType = sectionComponents[section].sectionType
        return header
    }
}

// MARK: - Top View Controller

extension PLOP {
    private func topViewController() -> UIViewController? {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }

        return topViewController(from: rootViewController)
    }

    private func topViewController(from viewController: UIViewController) -> UIViewController? {
        if let presentedVC = viewController.presentedViewController {
            return topViewController(from: presentedVC)
        }

        return viewController
    }
}

// MARK: - Shake Gesture

extension UIViewController {
    open override var canBecomeFirstResponder: Bool {
        return PLOP.isShakeEnabled
    }

    open override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if PLOP.isShakeEnabled && motion == .motionShake {
            PLOP.showPanel()
        }
    }
}
