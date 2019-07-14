//
//  ListOfCommentsView.swift
//  KeyToTech
//
//  Created by Oleksii on 7/14/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import UIKit

final class ListOfCommentsView: UIView {
    
    // MARK: - Properties
    // MARK: Public
    
    // MARK: Private
    
    var commentsTableView: UITableView!
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        self.setupCommentsTableView()
        self.setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    // MARK: Setup
    
    private func setupCommentsTableView() {
        self.commentsTableView = UITableView(frame: .zero, style: .plain)
        self.commentsTableView.separatorStyle = .none
        self.commentsTableView.backgroundColor = .black
        self.addSubview(self.commentsTableView)
    }

    private func setupConstraints() {
        self.commentsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.commentsTableView.topAnchor.constraint(equalTo: self.topAnchor),
            self.commentsTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.commentsTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.commentsTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
