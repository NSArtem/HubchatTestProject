//
//  PhotographyForum.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 19/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import Foundation
import Bender

class PhotographyForumModel {
    var uuid: String!
    var title: String?
    var description: String?
    var headerImageURL: String?
}

let photographyForumRule = ClassRule(PhotographyForumModel())
    .expect("forum"/"uuid", StringRule) { $0.uuid = $1 }
    .optional("forum"/"title", StringRule) { $0.title = $1 }
    .optional("forum"/"description", StringRule) { $0.description = $1 }
    .optional("forum"/"headerImage"/"url", StringRule) { $0.headerImageURL = $1 }
