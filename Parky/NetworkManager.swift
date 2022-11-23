//
//  NetworkManager.swift
//  Parky
//
//  Created by 李天骄 on 11/22/22.
//

import Alamofire
import Foundation

class NetworkManager {
    
    static let host = "http://34.150.235.148"
    
    static func getAllParkingLots(completion: @escaping ([ParkingLot]) -> Void) {
        let endpoint = "\(host)/parks/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                if let userResponse = try? jsonDecoder.decode(ParkingLotResponse.self, from: data) {
                    completion(userResponse.parks)
                } else {
                    print("Failed to decode getAllTickets")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
