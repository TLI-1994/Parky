//
//  Park.swift
//  Parky
//
//  Created by Haoyuan Shi on 11/22/22.
//

import Foundation

struct ParksResponse: Codable {
    var parks: [Park]
}


struct Park: Codable {
    var id: Int
    var name: String
    var latitude: String
    var longitude: String
    var address: String
    var hourlyRate: String
    var dailyRate: String
    var rateDays: String
    var openHours: String
    var note: String
    var comments: [Comment]

}

struct Comment: Codable {
    var id: Int
    var netid: String
    var comment: String
    var img: String
    
}
