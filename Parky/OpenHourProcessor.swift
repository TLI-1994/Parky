//
//  Utility.swift
//  Parky
//
//  Created by Haoyuan Shi on 11/23/22.
//

import Foundation

class OpenHourProcessor {
    
    let openHour: String
    
    func isEarlier(time1: String, time2: String) -> Bool {        
        let df = DateFormatter()
        df.dateFormat = "hh:mm a"
        
        let date1 = df.date(from: time1)
        let date2 = df.date(from: time2)
        df.dateFormat = "HH:mm"

        let time1_24 = df.string(from: date1!)
        let time2_24 = df.string(from: date2!)

        return time1_24 < time2_24
    }
    
    func parseTime(time: String) -> String {
        return "\(time.prefix(5)) \(time.suffix(2).uppercased())"
    }
    
    init(openTime: String) {
        self.openHour = openTime
    }
    
    func process() -> OpenHourProcessorResult {
        
        let start = parseTime(time: String(openHour.prefix(7)))
        let end = parseTime(time: String(openHour.suffix(7)))
        
        let df = DateFormatter()
        df.dateFormat = "hh:mm a"
        let curr = df.string(from: Date())

        
        return OpenHourProcessorResult(start: start, end: end, isOpen: isEarlier(time1: start, time2: curr) && isEarlier(time1: curr, time2: end))
        
    }
}

struct OpenHourProcessorResult {
    let start: String
    let end: String
    let isOpen: Bool
}
