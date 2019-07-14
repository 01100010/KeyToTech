//
//  ListOfCommentsViewModel.swift
//  KeyToTech
//
//  Created by Oleksii on 7/14/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import Foundation

final class ListOfCommentsViewModel {
    
    // MARK: - Properties
    // MARK: Callback
    
    var didFetchComments: ((NetworkManager.FetchCommentsResponse) -> Void)?
    
    // MARK: Private
    
    // MARK: - Methods
    // MARK: Public
    
    func fetchNextPartOfComments(_ lastCommentID: Int) {
        NetworkManager.shared.fetchComments(with: lastCommentID) { [weak self] (response) in
            DispatchQueue.main.async { [weak self] in
                self?.didFetchComments?(response)
            }
        }
    }
}
