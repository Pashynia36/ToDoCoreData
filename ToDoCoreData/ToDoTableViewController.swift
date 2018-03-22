//
//  ToDoTableViewController.swift
//  ToDoCoreData
//
//  Created by Pavlo Novak on 3/21/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit
import CoreData

class ToDoTableViewController: UITableViewController {

    let context = AppDelegate.viewContext
    var tasks: [Task] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        getData()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        cell.prepareForCell(task: tasks[indexPath.row], indexPath: indexPath.row, switchHandler: { (index, isOn) in
            self.tasks[index].isDone = isOn
            self.updateData(index: indexPath.row, switchStatus: isOn)
            
        })
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            getData()
        }
        tableView.reloadData()
    }
    
    func updateData(index: Int, switchStatus: Bool) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        let result = try? context.fetch(fetchRequest)
        let resultData = result as! [Task]
        resultData[index].isDone = switchStatus
        do {
            try context.save()
            print("Data change saved!")
        } catch  {
            print("Could not save data.")
        }
    }
    
    func getData() {
        
        do {
            tasks = try context.fetch(Task.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
}
