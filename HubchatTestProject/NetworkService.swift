//
//  HubchatNetworkService.swift
//  HubchatTestProject
//
//  Created by Artem Abramov on 19/02/2017.
//  Copyright © 2017 Artem Abramov. All rights reserved.
//

import Foundation
import Alamofire


class NetworkService {
    
    enum NetworkError: Error {
        case IncorrectEndpoint(String)
        case UnableToGetImage(String)
    }
    
    public let baseURL = URL(string: "https://api.hubchat.com/v1/")!

    func doRequest(endpoint: String, method: HTTPMethod, jsonParameters: [String: AnyObject]? = nil, completion: @escaping (Any) -> (), failure: @escaping (Error) -> ()) {
        //NOTE: A place to add authorization headers, repeating of failed  reqeusts and paramters to queries
        guard let url = urlForEndpoint(endpoint) else {
            failure(NetworkError.IncorrectEndpoint(endpoint))
            return
        }
        let request = { Alamofire.request(url, method: method, parameters: nil, encoding: JSONEncoding.default) }
        
        request().responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure(let error):
                failure(error)
            }
        }
    }
        
    func urlForEndpoint(_ endpoint: String) -> String? {
        return URL(string: endpoint, relativeTo: baseURL)?.absoluteString
    }
    
    func getPhotographyForum(success:  @escaping (PhotographyForumModel)->Void, failure: @escaping (Error)->Void) {
        doRequest(endpoint: "forum/photography", method: .get, completion: { data in
            do {
                let forumModel = try photographyForumRule.validate(data as AnyObject)
                success(forumModel)
            } catch let error {
                failure(error)
            }
        }, failure: failure)

    }
    
    func getImage(endpoint: String, success: @escaping (UIImage)->Void, failure: @escaping (Error)->Void) {
        Alamofire.request(endpoint).responseData { (response) in
            guard let data = response.result.value, let image = UIImage(data: data) else {
                failure(response.error ?? NetworkError.UnableToGetImage(endpoint))
                return
            }
            success(image)
        }
    }
    
    func getPosts(success:  @escaping (PostsFeed)->Void, failure: @escaping (Error)->Void) {
        doRequest(endpoint: "forum/photography/post", method: .get, completion: { data in
            do {
                let feed = try postFeedRule.validate(data as AnyObject)
                success(feed)
            } catch let error {
                failure(error)
            }
        }, failure: failure)
    }
    
}
