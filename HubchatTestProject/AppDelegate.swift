//
//  AppDelegate.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 19/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var network: NetworkService = NetworkService()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            window.backgroundColor = UIColor.white
            let headerViewModel = PhotoForumHeaderViewModel(networkService: network)
            let feedViewModel = PostsFeedViewModel(networkService: network)
            window.rootViewController = MainScreenController(headerViewModel: headerViewModel, feedViewModel: feedViewModel)
            window.makeKeyAndVisible()
        }
        return true
    }

}

