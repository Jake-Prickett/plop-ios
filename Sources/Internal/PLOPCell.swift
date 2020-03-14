//
//  PLOPCell.swift
//  PLOP
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

import Foundation

final class PLOPCell: UITableViewCell {
    static let reuseId = "PLOPCell"

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private var plopInputView: UIView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    private func configure() {
        selectionStyle = .none
        configureStackView()
    }

    private func configureStackView() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        let stackViewConstraints: [NSLayoutConstraint] = [
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -8)
        ]
        NSLayoutConstraint.activate(stackViewConstraints)
    }

    func add(inputView: UIView) {
        stackView.addArrangedSubview(inputView)
        inputView.translatesAutoresizingMaskIntoConstraints = false
        inputView.setContentHuggingPriority(.required, for: .horizontal)
        inputView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        plopInputView = inputView
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        plopInputView?.removeFromSuperview()
        plopInputView = nil
    }
}
