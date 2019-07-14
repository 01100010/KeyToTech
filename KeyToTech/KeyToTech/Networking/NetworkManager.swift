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
    
    func configureFetchCommentsURL(with id: Int) -> URL? {
        if var urlComponents = URLComponents(string: API.Endpoint.comments) {
            urlComponents.queryItems = []
            (1...Constant.commentsPerPage).forEach {
                urlComponents.queryItems?.append(.init(name: "id", value: String(id + $0))) // 🤷🏽‍♂️
            }
            
            if let url = urlComponents.url {
                return url
            }
        }
    
        return nil
    }
    
    func fetchComments(with lastCommentID: Int, completion: @escaping ((FetchCommentsResponse) -> Void)) {
        guard
            let url = self.configureFetchCommentsURL(with: lastCommentID)
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
