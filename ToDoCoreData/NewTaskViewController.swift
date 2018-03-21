//
//  NewTaskViewController.swift
//  ToDoCoreData
//
//  Created by Pavlo Novak on 3/21/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import UIKit
import CoreData

class NewTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var taskField: UITextField!
    @IBOutlet weak var descrField: UITextField!
    @IBOutlet weak var addLabel: UIButton!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        taskField.delegate = self
        descrField.delegate = self
        // Do any additional setup after loading the view.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        addLabel.isEnabled = true
        return true
    }

    @IBAction func addButton(_ sender: Any) {
        
        let context = AppDelegate.viewContext
        let task = Task(context: context)
        if let checkOne = taskField.text {
            task.task = checkOne
            if let checkTwo = descrField.text {
                task.descr = checkTwo
            }
        }
        
        // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        let _ = navigationController?.popViewController(animated: true)
    }
}
