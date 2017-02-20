//
//  PostCellViewModel.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 20/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import UIKit

class PostCellViewModel: ViewModelProtocol {

    struct PostImage {
        var width: Int?
        var height: Int?
        var image: UIImage?
    }
    
    typealias T = PostCellViewModel
    
    internal var didError: ((Error) -> Void)?
    internal var didUpdate: ((PostCellViewModel) -> Void)?
    
    private let model: PostModel?

    //ViewData
    var userImage: UIImage?
    var userName: String?
    var postText: String?
    var postImages: [PostImage]?
    var upvotes: String?
    
    func reloadData() {
        if let avatarURL = model?.avatarURL {
            self.network.getImage(endpoint: avatarURL, success: { userImage in
                self.userImage = userImage
                self.didUpdate?(self)
            }, failure: { debugPrint($0) })
        }
        
        if var images = postImages {
            for index in 0..<images.count {
                guard let url = model?.entities?[index].imageURL else { continue }
                self.network.getImage(endpoint: url, success: { image in
                    images[index].image = image
                    self.didUpdate?(self)
                }, failure: { debugPrint($0) })
            }
        }
        
        
    }

    private let network: NetworkService
    
    init(model: PostModel, network: NetworkService) {
//        var entities: [PostEntity]?
        self.model = model
        self.network = network
        self.userName = model.username
        self.upvotes = "\(model.upvotes) likes this post"
        self.postText = model.rawContent
        self.postImages = model.entities?.map() { PostImage(width: $0.width, height: $0.height, image: nil) }
    }

}
