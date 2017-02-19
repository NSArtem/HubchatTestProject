//
//  ViewController.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 19/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let network = HubchatNetworkService()
        network.getPhotographyForum { data in
            print(type(of: data))
            debugPrint(data)
        }
    }

}

