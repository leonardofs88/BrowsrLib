//
//  Organization.swift
//  BrowsrLib
//
//  Created by Leonardo Soares on 15/02/23.
//

import Foundation

public struct Organization: Codable {
    public let login: String?
    public let id: Int?
    public let url: String?
    public let reposUrl: String?
    public let avatarUrl: String?
    public let description: String?
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case url
        case reposUrl = "repos_url"
        case avatarUrl = "avatar_url"
        case description
    }
    
    public var isFavorite: Bool {
        if let loginKey = login {
            return UserDefaults.standard.bool(forKey: loginKey)
        } else {
            return false
        }
    }
}
