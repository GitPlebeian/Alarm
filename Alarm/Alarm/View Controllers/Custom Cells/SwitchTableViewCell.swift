//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Jackson Tubbs on 8/5/19.
//  Copyright © 2019 Jax Tubbs. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func cellSettingSwitchValueChanged(cell: SwitchTableViewCell, isOn: Bool)
}

class SwitchTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var alarmTimeLabel: UILabel!
    @IBOutlet weak var alarmNameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    // MARK: - Properties
    
    weak var delegate: SwitchTableViewCellDelegate?
    var alarm: Alarm?{
        didSet {
            updateView()
        }
    }
    
    
    // MARK: - Actions

    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.cellSettingSwitchValueChanged(cell: self, isOn: alarmSwitch.isOn)
    }

    // MARK: - Custom Functions
    
    func updateView() {
        if let alarm = alarm {
            alarmTimeLabel.text = alarm.fireTimeAsString
            alarmNameLabel.text = alarm.name
            alarmSwitch.isOn = alarm.enabled
        } else {
            // Reuse
        }
    }
}
