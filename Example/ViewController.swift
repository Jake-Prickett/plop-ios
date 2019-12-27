//
//  ViewController.swift
//  PLOPExample
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

import UIKit
import PLOP

class ViewController: UIViewController {

    var buttonAction: ((UIButton) -> Void) = { _ in
        print("tapped button")
    }

    var switchAction: ((UISwitch) -> Void) = { _ in
        print("toggled switch")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(type: .system)
        button.setTitle("Show Panel", for: .normal)
        button.addTarget(self, action: #selector(togglePLOP), for: .touchUpInside)

        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        configurePLOP()
    }

    private func configurePLOP() {
        let section1 = SectionPLOPComponent(title: "Feature Flags",
                                            components: [
                                                ButtonPLOPComponent(title: "Button Component 1", action: buttonAction),
                                                SwitchPLOPComponent(title: "Switch Component 1", action: switchAction)],
                                            sectionType: .featureFlag)

        let section2 = SectionPLOPComponent(title: "Location",
                                            components: [
                                                ButtonPLOPComponent(title: "Button Component 2", action: buttonAction),
                                                SwitchPLOPComponent(title: "Switch Component 2", action: switchAction)],
                                            sectionType: .location)

        let section3 = SectionPLOPComponent(title: "Other",
                                            components: [
                                                ButtonPLOPComponent(title: "Button Component 3", action: buttonAction),
                                                SwitchPLOPComponent(title: "Switch Component 3", action: switchAction)],
                                            sectionType: .other)

        PLOP.add(section: section1)
        PLOP.add(section: section2)
        PLOP.add(section: section3)

        PLOP.reloadPanel()
    }

    @objc func togglePLOP() {
        PLOP.showPanel()
    }
}
