//
//  GithubRepoModel.swift
//  iOSTechnicalTask
//
//  Created by mac on 3/5/21.
//

import UIKit

struct GithubRepoModel: Decodable {
    var id: Int?
    var title: String?
    var description: String?
    var owner: RepoOwner?

    private enum CodingKeys: String, CodingKey {
        case id, title = "name", description, owner
    }
}

struct RepoOwner: Decodable {
    var id: Int?
    var name: String?
    var avatarImageUrl: String?
    private enum CodingKeys: String, CodingKey {
        case id, name = "login", avatarImageUrl = "avatar_url"
    }
}
