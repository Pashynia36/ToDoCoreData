//
//  TaskTableViewCell.swift
//  ToDoCoreData
//
//  Created by Pavlo Novak on 3/21/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var descrLabel: UILabel!
    @IBOutlet weak var switchIfDone: UISwitch!
    
    var cellIndex: Int = 0
    private var switchHandler: ((Int, Bool) -> Void)?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
    }
    
    func prepareForCell(task: Task, indexPath: Int, switchHandler: @escaping (Int, Bool) -> Void) {
        
        cellIndex = indexPath
        switchIfDone.isOn = task.isDone
        taskLabel.text = task.task
        if let text = task.descr {
            descrLabel.text = text
        }
        self.switchHandler = switchHandler
    }
    
    @IBAction func isPressed(_ sender: UISwitch) {
        if let switchHandler = self.switchHandler {
            switchHandler(cellIndex, sender.isOn)
        }
    }
}
