//
//  PhotographyForumHeaderViewModel.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 19/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import UIKit

protocol ViewModelProtocol {
    associatedtype T
    var didUpdate: ((T)->Void)? { get set }
    var didError: ((Error)->Void)? { get set }
    func reloadData()
}

class PhotoForumHeaderViewModel: ViewModelProtocol {
    
    internal var didError: ((Error) -> Void)?
    internal var didUpdate: ((PhotoForumHeaderViewModel) -> Void)?
    
    fileprivate(set) var isUpdating: Bool = false
    private let network: NetworkService

    typealias T = PhotoForumHeaderViewModel
    
    init(networkService: NetworkService) {
        self.network = networkService
    }

    //ViewData
    var headerImage: UIImage?
    var title: String?
    var description: String?
    
    //MARK: - Actions
    func reloadData() {
        isUpdating = true
        
        self.network.getPhotographyForum(success: { model in
            self.title = model.title
            self.description = model.description
            if let url = model.headerImageURL {
                self.network.getImage(endpoint: url, success: { image in
                    model.headerImage = image
                    self.headerImage = model.headerImage
                    self.didUpdate?(self)
                }, failure: { debugPrint($0) })
            }
            self.isUpdating = false
            self.didUpdate?(self)
        }, failure: { error in
            self.didError?(error)
        })
        
    }
}
