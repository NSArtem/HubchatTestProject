//
//  PhotographyForumViewModel.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 19/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import UIKit

class PostsFeedViewModel: ViewModelProtocol {
    
    typealias T = PostsFeedViewModel
    internal var didError: ((Error) -> Void)?
    internal var didUpdate: ((PostsFeedViewModel) -> Void)?
    
    private let network: NetworkService
    
    init(networkService: NetworkService) {
        self.network = networkService
    }
    
    private(set) var postCells: [PostCellViewModel]?
    

    
    func reloadData() {
        network.getPosts(success: { (feedModel) in
            self.postCells = feedModel.posts.map() { PostCellViewModel(model: $0, network: self.network) }
            self.didUpdate?(self)
        }) { (error) in
            self.didError?(error)
        }
    }
}

