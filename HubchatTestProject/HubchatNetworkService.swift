//
//  HubchatNetworkService.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 19/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import Foundation
import Alamofire


class HubchatNetworkService {
    
    public let baseURL = URL(string: "https://api.hubchat.com/v1/")!

    func doRequest(endpoint: String, method: HTTPMethod, jsonParameters: [String: AnyObject]? = nil, completion: @escaping (Any) -> ()) {
        //NOTE: A place to add authorization headers, repeating of failed  reqeusts and paramters to queries
        let request = { Alamofire.request(self.urlForEndpoint(endpoint), method: method, parameters: nil, encoding: JSONEncoding.default) }
        
        request().responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(value)
                debugPrint(value)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
        
    func urlForEndpoint(_ endpoint: String) -> String {
        //TODO: gross
        return NSURL(string: endpoint, relativeTo: self.baseURL)!.absoluteString!
    }
    
    func getPhotographyForum(completion:  @escaping (Any) -> ()) {
        doRequest(endpoint: "forum/photography", method: .get, completion: completion)
    }
    
    func getPosts(completion: @escaping (Any) -> ()) {
        doRequest(endpoint: "forum/photography/post", method: .get, completion: completion)
    }
    
}
