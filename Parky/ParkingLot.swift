//
//  ParkingLot.swift
//  Parky
//
//  Created by 李天骄 on 11/22/22.
//

import Foundation

struct Comment: Codable {
    var id: Int
    var netid: String
    var comment: String
    var img: String
}

struct ParkingLot: Codable {
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

struct ParkingLotResponse: Codable {
    var parks: [ParkingLot]
}
