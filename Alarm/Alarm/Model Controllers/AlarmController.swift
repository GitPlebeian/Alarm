//
//  AlarmController.swift
//  Alarm
//
//  Created by Jackson Tubbs on 8/5/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import Foundation

class AlarmController {
    
    // MARK: - Singletons
    
    static var shared = AlarmController()
    
    // MARK: - Properties
    
    var alarms: [Alarm] = []
    var mockAlarms: [Alarm] = [Alarm(fireDate: Date(), name: "Ten Boi", enabled: true),Alarm(fireDate: Date(), name: "Teasdfasdfn Boi", enabled: false)]

    init() {
        alarms = mockAlarms
    }

    
    // MARK: - CRUD
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(alarm)
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        guard let alarmIndex = alarms.firstIndex(of: alarm) else {return}
        let oldAlarm = alarms[alarmIndex]
        oldAlarm.name = name
        oldAlarm.fireDate = fireDate
        oldAlarm.enabled = enabled
    }
    
    func delete(alarm: Alarm) {
        guard let alarmIndex = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: alarmIndex)
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
    }
}
