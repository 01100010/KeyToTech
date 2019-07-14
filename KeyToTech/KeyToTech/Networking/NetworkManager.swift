//
//  NetworkManager.swift
//  KeyToTech
//
//  Created by Oleksii on 7/14/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import Foundation

final class NetworkManager {
    
    // MARK: - Types
    // MARK: Typealias
    
    typealias API = Constant.API
    typealias FetchCommentsResponse = Result<[Comment], NetworkError>
    
    // MARK: - Properties
    // MARK: Singleton
    
    static let shared: NetworkManager = .init()
    private(set) lazy var decoder: JSONDecoder = .init()
    
    // MARK: - Initialization
    
    private init() { }
    
    // MARK: - Methods
    
    func fetchComments(completion: @escaping ((FetchCommentsResponse) -> Void)) {
        guard
            let url = URL(string: API.Endpoint.comments)
        else {
            return completion(.failure(NetworkError.invalidURL))
        }
        
        let _ = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                return completion(.failure(NetworkError.error(error!)))
            }
            
            guard let data = data else {
                return completion(.failure(NetworkError.invalidData))
            }
            
            guard let comments = try? self.decoder.decode([Comment].self, from: data) else {
                return completion(.failure(NetworkError.decodingError))
            }
            
            completion(.success(comments))
        }.resume()
    }
}
