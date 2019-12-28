//
//  ViewController.swift
//  PLOPExample
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

import UIKit
import PLOP
import SafariServices

class ViewController: UIViewController {

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
        configureSection1()
        configureSection2()
        configureSection3()

        PLOP.reloadPanel()
    }

    private func configureSection1() {
        let section1 = SectionPLOPComponent(
            title: "Feature Flags",
            components: [
                ButtonPLOPComponent(title: "Button 1", buttonTitle: "Go!", action: { _ in

                    let alert = UIAlertController(title: "Gone!", message: "I went there", preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    PLOP.plopNavigationController?.present(alert, animated: true, completion: nil)
                }),
                SwitchPLOPComponent(title: "Switch 1", action: { component in

                    let alert = UIAlertController(title: "Switched!", message: "Switched to \(component.isOn)", preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    PLOP.plopNavigationController?.present(alert, animated: true, completion: nil)
                })],
            sectionType: .featureFlag
        )
        PLOP.add(section: section1)
    }

    private func configureSection2() {
        let section2 = SectionPLOPComponent(
            title: "Locations",
            components: [
                ButtonPLOPComponent(title: "Apple Website", buttonTitle: "Go!", action: { _ in
                    let vc = SFSafariViewController(url: URL(string: "https://www.apple.com")!)
                    PLOP.plopNavigationController?.pushViewController(vc, animated: true)
                }),
                SwitchPLOPComponent(title: "Switch 2", action: { component in

                    let alert = UIAlertController(title: "Switched!", message: "Switched to \(component.isOn)", preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    PLOP.plopNavigationController?.present(alert, animated: true, completion: nil)
                })],
            sectionType: .location
        )
        PLOP.add(section: section2)
    }

    private func configureSection3() {
        let section3 = SectionPLOPComponent(
            title: "Other",
            components: [
                ButtonPLOPComponent(title: "Medium Website", buttonTitle: "Read!", action: { _ in
                    let vc = SFSafariViewController(url: URL(string: "https://medium.com/")!)
                    vc.modalPresentationStyle = .pageSheet
                    PLOP.plopNavigationController?.present(vc, animated: true, completion: nil)
                }),
                SwitchPLOPComponent(title: "Switch 3", action: { component in

                    let alert = UIAlertController(title: "Switched!",
                                                  message: "I went there - switch to \(component.isOn)",
                                                  preferredStyle: UIAlertController.Style.alert)

                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                    PLOP.plopNavigationController?.present(alert, animated: true, completion: nil)
                })],
            sectionType: .other
        )
        PLOP.add(section: section3)
    }

    @objc func togglePLOP() {
        PLOP.showPanel()
    }
}
