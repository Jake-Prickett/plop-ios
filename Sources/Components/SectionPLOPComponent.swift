//
//  SectionPLOPComponent.swift
//  PLOP
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

import Foundation

open class SectionPLOPComponent {
    public let title: String?
    open var components: [PLOPComponent]
    public var sectionType: PLOPSectionType
    
    public init(title: String? = nil, components: [PLOPComponent] = [], sectionType: PLOPSectionType = .other) {
        self.title = title
        self.components = components
        self.sectionType = sectionType
    }
}

public enum PLOPSectionType {
    case featureFlag
    case location
    case other
}
