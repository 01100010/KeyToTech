//
//  Comment.swift
//  KeyToTech
//
//  Created by Oleksii on 7/14/19.
//  Copyright © 2019 Oleksii Lukashuk. All rights reserved.
//

import Foundation

struct Comment: Decodable {
    let id: Int
    let name: String
    let email: String
    let body: String
}
