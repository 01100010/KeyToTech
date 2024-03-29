//
//  InitialInputViewModel.swift
//  KeyToTech
//
//  Created by Oleksii on 7/14/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import Foundation

final class InitialInputViewModel {
    
    // MARK: - Properties
    // MARK: Callback
    
    var didFetchComments: ((NetworkManager.FetchCommentsResponse) -> Void)?
    
    // MARK: - Methods
    // MARK: Public
    
    func fetchComments(with id: Int) {
        NetworkManager.shared.fetchComments(with: id) { [weak self] (response) in
            DispatchQueue.main.async { [weak self] in
                self?.didFetchComments?(response)
            }
        }
    }
}
