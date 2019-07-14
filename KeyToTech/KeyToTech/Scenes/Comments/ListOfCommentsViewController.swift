//
//  ListOfCommentsViewController.swift
//  KeyToTech
//
//  Created by Oleksii on 7/14/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import UIKit

final class ListOfCommentsViewController: UIViewController {
    
    // MARK: - Properties
    // MARK: Public
    
    let viewModel: ListOfCommentsViewModel = .init()
    let rootView: ListOfCommentsView = .init()
    var shouldShowActivityCell: Bool = true
    
    var lowerBound: Int
    var upperBound: Int
    var comments: [Comment] = []
    
    // MARK: - Initialization
    
    init(with comments: [Comment], lowerBound: Int, upperBound: Int) {
        self.lowerBound = lowerBound
        self.upperBound = upperBound
        super.init(nibName: nil, bundle: nil)
        self.updateUI(with: comments)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = self.rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.setupRootView()
        self.setupViewModel()
    }
    
    // MARK: Setup
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Comments"
        if #available(iOS 11.0, *) {
            self.navigationItem.hidesSearchBarWhenScrolling = false
            self.navigationItem.searchController = {
                let searchController = UISearchController(searchResultsController: nil)
                searchController.delegate = self
                searchController.obscuresBackgroundDuringPresentation = true
                return searchController
            }()
        } else {
            self.navigationItem.titleView = {
                let searchBar = UISearchBar()
                searchBar.delegate = self
                return searchBar
            }()
        }
        
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.isTranslucent = true
        
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    private func setupRootView() {
        self.rootView.commentsTableView.register(
            CommentTableViewCell.self,
            forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier
        )
        
        self.rootView.commentsTableView.register(
            ActivityTableViewCell.self,
            forCellReuseIdentifier: ActivityTableViewCell.reuseIdentifier
        )
        

        self.rootView.commentsTableView.delegate = self
        self.rootView.commentsTableView.dataSource = self
        self.rootView.commentsTableView.estimatedRowHeight = 100
        self.rootView.commentsTableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupViewModel() {
        self.viewModel.didFetchComments = { [weak self] (result) in
            switch result {
            case .success(let newComments):
                self?.updateUI(with: newComments)
            case .failure(let error):
                self?.showErrorAlert(error)
            }
        }
    }
    
    private func updateUI(with newComments: [Comment]) {
        let filteredComments = newComments.filter { $0.id >= lowerBound && $0.id <= upperBound }
        
        if !filteredComments.isEmpty {
            self.comments = (self.comments + filteredComments).sorted { $0.id < $1.id }
        } else {
            self.shouldShowActivityCell = false
        }
        
        self.rootView.commentsTableView.reloadData()
    }
}

// MARK: - SearchController Delegate
extension ListOfCommentsViewController: UISearchControllerDelegate {
    
}

// MARK: - SearchBar Delegate
extension ListOfCommentsViewController: UISearchBarDelegate {
    
}

// MARK: - TableView DataSource
extension ListOfCommentsViewController: UITableViewDataSource {
    enum Section: Int, CaseIterable {
        case comment
        case activity
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section.allCases[section] {
        case .comment:
            return self.comments.count
        case .activity:
            return self.shouldShowActivityCell ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch Section.allCases[indexPath.section] {
        case .comment:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.reuseIdentifier, for: indexPath) as? CommentTableViewCell {
                cell.comment = self.comments[indexPath.row]
                return cell
            }
        case .activity:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.reuseIdentifier, for: indexPath) as? ActivityTableViewCell {
                cell.start()
                return cell
            }
        }
        
        preconditionFailure("There is an problem with Cell Dequeue!")
    }
}

extension ListOfCommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        switch Section.allCases[indexPath.section] {
        case .comment:
            return
        case .activity:
            if !self.comments.isEmpty {
                self.viewModel.fetchNextPartOfComments(self.comments.last!.id)
            }
        }
    }
}
