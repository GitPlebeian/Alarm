//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Jackson Tubbs on 8/5/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var alarmEnableDisableButton: UIButton!
    
    // MARK: - Properties
    
    var enableDisableAlarm: Bool = true
    
    var alarm: Alarm? {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Custom Methods
    
    func updateView() {
        loadViewIfNeeded()
        guard let alarm = alarm else {return}
        
        alarmDatePicker.date = alarm.fireDate
        alarmNameTextField.text = alarm.name
        if alarm.enabled {
            alarmEnableDisableButton.setTitle("Enabled", for: .normal)
            enableDisableAlarm = true
        } else {
            alarmEnableDisableButton.setTitle("Disabled", for: .normal)
            enableDisableAlarm = false
        }
    }
    
    // MARK: - Actions
    
    @IBAction func alarmEnableDisableButtonTapped(_ sender: Any) {
        enableDisableAlarm = !enableDisableAlarm
        if enableDisableAlarm == true {
            alarmEnableDisableButton.setTitle("Enabled", for: .normal)
        } else {
            alarmEnableDisableButton.setTitle("Disabled", for: .normal)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let alarmName = alarmNameTextField.text else {return}
        if alarmName.isEmpty {return}
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireDate: alarmDatePicker.date, name: alarmName, enabled: enableDisableAlarm)
        } else {
            AlarmController.shared.addAlarm(fireDate: alarmDatePicker.date, name: alarmName, enabled: enableDisableAlarm)
        }
        navigationController?.popViewController(animated: true)
    }
    
}
