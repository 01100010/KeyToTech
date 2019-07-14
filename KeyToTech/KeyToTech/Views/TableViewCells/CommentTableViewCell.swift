//
//  CommentTableViewCell.swift
//  KeyToTech
//
//  Created by Oleksii on 7/14/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import UIKit

final class CommentTableViewCell: TableViewCell {
    
    // MARK: - Properties
    // MARK: Public
    
    var comment: Comment? {
        didSet {
            self.idLabel.text = String(self.comment?.id ?? -1)
            self.nameLabel.text = self.comment?.name
            self.bodyTextView.text = self.comment?.body
            self.emailLabel.text = self.comment?.email
        }
    }
    
    // MARK: Private
    
    private var idContainerView: UIView!
    private var idLabel: UILabel!
    private var nameLabel: UILabel!
    private var bodyTextView: UITextView!
    private var emailLabel: UILabel!
    private var bottomSeparatorView: UIView!
    
    // MARK: - Initialization
    
    override func initialSetup() {
        super.initialSetup()
        self.setupContentView()
        self.setupIDContainerView()
        self.setupIdLabel()
        self.setupNameLabel()
        self.setupBodyLabel()
        self.setupEmailLabel()
        self.setupBottomSeparatorView()
        
        #if DEBUG
        self.setupDefaultValues()
        #endif
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        self.idContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.idLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.bodyTextView.translatesAutoresizingMaskIntoConstraints = false
        self.emailLabel.translatesAutoresizingMaskIntoConstraints = false
        self.bottomSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.idContainerView.widthAnchor.constraint(equalToConstant: 50),
            self.idContainerView.heightAnchor.constraint(equalToConstant: 25),
            self.idContainerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.idContainerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            self.idLabel.centerXAnchor.constraint(equalTo: self.idContainerView.centerXAnchor),
            self.idLabel.centerYAnchor.constraint(equalTo: self.idContainerView.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.idContainerView.trailingAnchor, constant: 8),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            self.bodyTextView.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 8),
            self.bodyTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.bodyTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            self.emailLabel.topAnchor.constraint(equalTo: self.bodyTextView.bottomAnchor, constant: 8),
            self.emailLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            self.emailLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            self.emailLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ])
        
        NSLayoutConstraint.activate([
            self.bottomSeparatorView.heightAnchor.constraint(equalToConstant: 1),
            self.bottomSeparatorView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.bottomSeparatorView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.bottomSeparatorView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Methods
    // MARK: Setup
    
    private func setupDefaultValues() {
        self.idLabel.text = "1"
        self.nameLabel.text = "et fugit eligendi deleniti quidem qui sint nihil autem"
        self.bodyTextView.text = "doloribus at sed quis culpa deserunt consectetur qui praesentium accusamus fugiat dicta voluptatem rerum ut voluptate autem voluptatem repellendus aspernatur dolorem in"
        self.emailLabel.text = "email: Presley.Mueller@myrl.com"
    }
    
    private func setupContentView() {
        self.contentView.backgroundColor = .black
        self.selectionStyle = .none
    }
    
    private func setupIDContainerView() {
        self.idContainerView = UIView()
        self.idContainerView.backgroundColor = .groupTableViewBackground
        self.idContainerView.cornerRadius = 12.5
        self.contentView.addSubview(self.idContainerView)
    }
    
    private func setupIdLabel() {
        self.idLabel = UILabel()
        self.idLabel.textAlignment = .center
        self.idLabel.font = .systemFont(ofSize: 21, weight: .semibold)
        self.idContainerView.addSubview(self.idLabel)
    }
    
    private func setupNameLabel() {
        self.nameLabel = UILabel()
        self.nameLabel.textColor = .white
        self.nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        self.nameLabel.adjustsFontSizeToFitWidth = true
        self.contentView.addSubview(self.nameLabel)
    }
    
    private func setupBodyLabel() {
        self.bodyTextView = UITextView()
        self.bodyTextView.textContainerInset = .zero
        self.bodyTextView.textContainer.lineFragmentPadding = 0
        self.bodyTextView.backgroundColor = .clear
        self.bodyTextView.textColor = .white
        self.bodyTextView.font = .systemFont(ofSize: 15, weight: .medium)
        self.bodyTextView.isScrollEnabled = false
        self.contentView.addSubview(self.bodyTextView)
    }
    
    private func setupEmailLabel() {
        self.emailLabel = UILabel()
        self.emailLabel.textColor = .groupTableViewBackground
        self.emailLabel.font = .systemFont(ofSize: 12.5, weight: .medium)
        self.contentView.addSubview(self.emailLabel)
    }
    
    private func setupBottomSeparatorView() {
        self.bottomSeparatorView = UIView()
        self.bottomSeparatorView.backgroundColor = .groupTableViewBackground
        self.contentView.addSubview(self.bottomSeparatorView)
    }
}
