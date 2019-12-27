//
//  BasePLOPControlComponent.swift
//  PLOP
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

import Foundation

open class BasePLOPControlComponent<T: UIControl>: PLOPComponent {
    public typealias ControlType = T
    
    public let title: String
    public let action: ((ControlType) -> Void)
    public let inputView: UIView?
    
    public var control: ControlType? {
        guard let control = inputView as? ControlType? else {
            fatalError("Cannot cast \(String(describing: inputView)) to \(String(describing: ControlType.self))")
        }
        return control
    }
    
    public init(title: String, control: ControlType, action: @escaping ((ControlType) -> Void), controlEvent: UIControl.Event) {
        self.title = title
        self.inputView = control
        self.action = action
        self.control?.addTarget(self, action: #selector(executeAction), for: controlEvent)
    }
    
    @objc private func executeAction() {
        guard let control = control else {
            return
        }
        self.action(control)
    }
}
