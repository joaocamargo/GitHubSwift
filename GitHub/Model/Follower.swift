//
//  Follower.swift
//  GitHub
//
//  Created by joao camargo on 31/08/21.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(login)
//    }
}
