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
//        alarms = mockAlarms
    }

    
    // MARK: - CRUD
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) {
        let alarm = Alarm(fireDate: fireDate, name: name, enabled: enabled)
        alarms.append(alarm)
        saveToPersistentStore()
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        guard let alarmIndex = alarms.firstIndex(of: alarm) else {return}
        let oldAlarm = alarms[alarmIndex]
        oldAlarm.name = name
        oldAlarm.fireDate = fireDate
        oldAlarm.enabled = enabled
        saveToPersistentStore()
    }
    
    func delete(alarm: Alarm) {
        guard let alarmIndex = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: alarmIndex)
        saveToPersistentStore()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        saveToPersistentStore()
    }
    
    // MARK: - Persistence
    
    func createFileURLForPersistence() -> URL {
        // Grab the users document directory
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // Create the new fileURL on user's phone
        let fileURL = urls[0].appendingPathComponent("Alarm.json")
        
        return fileURL
    }
    
    func saveToPersistentStore() {
        // Create an instance of JSON Encoder
        let jsonEncoder = JSONEncoder()
        // Attempt to convert our quotes to JSON
        do {
            let jsonThings = try jsonEncoder.encode(alarms)
            // With the new json(d) quote, save it to the users device
            try jsonThings.write(to: createFileURLForPersistence())
        } catch let encodingError {
            // Handle the error, if there is one
            print("There was an error saving!! \(encodingError)")
        }
    }
    
    func loadFromPersistentStore() {
        // The data we want will be JSON, and I want it to be a Quote.
        let jsonDecoder = JSONDecoder()
        //Decode the data
        do {
            let jsonData = try Data(contentsOf: createFileURLForPersistence())
            let decodedPlaylist = try jsonDecoder.decode([Alarm].self, from: jsonData)
            alarms = decodedPlaylist
        } catch let decodingError {
            print("There was an error decoding!! \(decodingError.localizedDescription)")
        }
    }
}
