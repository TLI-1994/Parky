//
//  NetworkManager.swift
//  Parky
//
//  Created by Haoyuan Shi on 11/22/22.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let host = "http://34.150.235.148"
    
    static func getAllParks(completion: @escaping ([Park]) -> Void) {
        let endpoint = "\(host)/parks/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(ParksResponse.self, from: data) {
                    let parks = userResponse.parks
                    completion(parks)
                } else {
                    print("Failed to decode getAllPosts")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    static func addComment(park_id: Int, netid: String = "aa1" ,comment: String, image_data: String?, completion: @escaping (Comment) -> Void) {
        let endpoint = "\(host)/parks/\(park_id)/comment/"
        let params:Parameters = [
            "netid": netid,
            "comment": comment,
            "image_data": image_data as Any,
            
        ]
        AF.request(endpoint,method: .post, parameters: params, encoding: JSONEncoding.default).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(Comment.self, from:data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode creatPost")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            
        }
            
    }
    
    
}
