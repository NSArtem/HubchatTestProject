//
//  PostCellViewModel.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 19/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import UIKit
import Bender

class PostsFeed {
    var posts: [PostModel]!
}

class PostModel {
    var uuid: String!
    var rawContent: String?
    var username: String?
    var avatarURL: String?
    var entities: [PostEntity]?
    var upvotes: Int?
}

class PostEntity {
    var imageURL: String?
    var height: Int?
    var width: Int?
}

let postFeedRule = ClassRule(PostsFeed())
    .expect("posts", ArrayRule(itemRule: postModelRule)) { $0.posts = $1 }

let postModelRule = ClassRule(PostModel())
    .expect("uuid", StringRule) { $0.uuid = $1 }
    .optional("rawContent", StringRule) { $0.rawContent = $1 }
    .optional("createdBy"/"username", StringRule) { $0.username = $1 }
    .optional("createdBy"/"avatar"/"url", StringRule) { $0.avatarURL = $1 }
    .optional("entities"/"images", ArrayRule(itemRule: entityRule)) { $0.entities = $1 }
    .optional("stats"/"upVotes", IntRule) { $0.upvotes = $1 }

let entityRule = ClassRule(PostEntity())
    .optional("cdnUrl", StringRule) { $0.imageURL = $1 }
    .optional("width", IntRule) { $0.width = $1 }
    .optional("height", IntRule) { $0.height = $1 }
