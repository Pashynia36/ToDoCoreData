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
        let task = tasks[indexPath.row]
        cell.taskLabel.text = task.task
        if let text = task.descr {
            cell.descrLabel.text = text
        }
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
    
    func getData() {
        
        do {
            tasks = try context.fetch(Task.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
    }
}
