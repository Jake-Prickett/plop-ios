//
//  ButtonPLOPComponent.swift
//  PLOP
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

import Foundation

public final class ButtonPLOPComponent: BasePLOPControlComponent<UIButton> {

    public init(title: String, buttonTitle: String = "Do it!", action: @escaping ((ControlType) -> Void)) {
        let controlButton = UIButton(type: .system)
        controlButton.setTitle(buttonTitle, for: .normal)
        controlButton.tintColor = .darkModeBlue
        super.init(title: title, control: controlButton, action: action, controlEvent: .touchUpInside)
    }
}
