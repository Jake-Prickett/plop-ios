//
//  SwitchPLOPComponent.swift
//  PLOP
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Foundation

public final class SwitchPLOPComponent: BasePLOPControlComponent<UISwitch> {
    public init(title: String, isOn: Bool = false, action: @escaping ((ControlType) -> Void)) {
        let controlSwitch = UISwitch()
        controlSwitch.isOn = isOn
        controlSwitch.onTintColor = .systemBlue
        super.init(title: title, control: controlSwitch, action: action, controlEvent: .valueChanged)
    }
}
#endif
