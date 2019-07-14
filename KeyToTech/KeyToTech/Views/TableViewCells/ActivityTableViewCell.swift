//
//  ActivityTableViewCell.swift
//  KeyToTech
//
//  Created by Oleksii on 7/14/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import UIKit

final class ActivityTableViewCell: TableViewCell {
    
    // MARK: - Properties
    // MARK: Private
    
    private var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - Initialization
    
    override func initialSetup() {
        super.initialSetup()
        self.setupContentView()
        self.setupActivityIndicatorView()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.activityIndicatorView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            self.activityIndicatorView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
    }
    
    // MARK: - Methods
    // MARK: Public
    
    func start() {
        self.activityIndicatorView.startAnimating()
    }
    
    func stop() {
        self.activityIndicatorView.stopAnimating()
    }
    
    // MARK: Setup
    
    private func setupContentView() {
        self.contentView.backgroundColor = .black
        self.selectionStyle = .none
    }
    
    private func setupActivityIndicatorView() {
        self.activityIndicatorView = UIActivityIndicatorView.init(style: .whiteLarge)
        self.activityIndicatorView.startAnimating()
        self.contentView.addSubview(self.activityIndicatorView)
    }
}

