//
//  Alarm.swift
//  Alarm
//
//  Created by Jackson Tubbs on 8/5/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import Foundation

class Alarm: Codable {
    
    var fireDate: Date
    var name: String
    var enabled: Bool
    var uuid: String
    var fireTimeAsString: String {
        get {
            let format = DateFormatter()
            format.dateFormat = "h:mm a"
            return format.string(from: fireDate)
        }
    }
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
    }
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool{
        return
            lhs.fireDate == rhs.fireDate &&
            lhs.name == rhs.name &&
            lhs.enabled == rhs.enabled &&
            lhs.uuid == rhs.uuid
    }
}
