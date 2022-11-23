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
    
    
}
