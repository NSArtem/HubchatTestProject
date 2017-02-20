//
//  ViewModelProtocol.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 20/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype T
    var viewModelDidUpdate: ((T)->Void)? { get set }
    var viewModelDidError: ((Error)->Void)? { get set }
    func reloadData()
    
}
