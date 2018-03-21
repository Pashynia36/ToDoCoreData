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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        addLabel.isEnabled = true
        return true
    }

    @IBAction func addButton(_ sender: Any) {
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = Task(context: context) // Link Task & Context
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
