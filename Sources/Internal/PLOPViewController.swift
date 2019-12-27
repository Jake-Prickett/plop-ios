//
//  PLOPViewController.swift
//  PLOP
//
//  Created by Jake Prickett on 12/27/19.
//  Copyright © 2019 Jake Prickett. All rights reserved.
//

import UIKit

final class PLOPViewController: UIViewController {
    
    init(dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
        super.init(nibName: nil, bundle: nil)
        tableView.dataSource = dataSource
        tableView.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.estimatedRowHeight = 44
        tv.rowHeight = UITableView.automaticDimension
        tv.tableFooterView = UIView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorColor = .darkGray
        tv.backgroundColor = .darkModeBackground
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.tintColor = nil
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.barTintColor = .darkModeBackground
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        setNeedsStatusBarAppearanceUpdate()
    }
    
    private func configure() {
        view.backgroundColor = .darkModeBackground
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        tableView.register(PLOPCell.self, forCellReuseIdentifier: PLOPCell.reuseId)
        tableView.register(PLOPSectionHeader.self, forHeaderFooterViewReuseIdentifier: PLOPSectionHeader.reuseId)
        tableView.reloadData()
    }
    
    func reload() {
        tableView.reloadData()
    }
}
