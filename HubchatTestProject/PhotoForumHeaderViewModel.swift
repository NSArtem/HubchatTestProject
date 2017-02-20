//
//  PhotographyForumHeaderViewModel.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 19/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import UIKit

class PhotoForumHeaderViewModel: ViewModelProtocol {
    
    internal var viewModelDidError: ((Error) -> Void)?
    internal var viewModelDidUpdate: ((PhotoForumHeaderViewModel) -> Void)?
    
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
                    self.headerImage = image
                    self.viewModelDidUpdate?(self)
                }, failure: { debugPrint($0) })
            }
            self.isUpdating = false
            self.viewModelDidUpdate?(self)
        }, failure: { error in
            self.viewModelDidError?(error)
        })
        
    }
}
