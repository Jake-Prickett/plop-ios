//
//  PLOPSectionHeader.swift
//  PLOP
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

#if canImport(UIKit)
import Foundation

final class PLOPSectionHeader: UITableViewHeaderFooterView {
    static let reuseId = "PLOPSectionHeader"

    var sectionType: PLOPSectionType = .other {
        didSet {
           setBackgroundColor()
        }
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setBackgroundColor()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        sectionType = .other
    }

    private func setBackgroundColor() {
        switch sectionType {
        case .featureFlag:
            contentView.backgroundColor = .systemBlue
        case .location:
            contentView.backgroundColor = .systemRed
        case .debugTools:
            contentView.backgroundColor = .systemPink
        case .development:
            contentView.backgroundColor = .systemTeal
        case .configuration:
            contentView.backgroundColor = .systemGreen
        case .other:
            contentView.backgroundColor = .systemPurple
        }
    }
}
#endif
