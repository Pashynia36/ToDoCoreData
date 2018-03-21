//
//  CoreDataHandler.swift
//  ToDoCoreData
//
//  Created by Pavlo Novak on 3/21/18.
//  Copyright © 2018 Pavlo Novak. All rights reserved.
//

import Foundation
import CoreData

class CoreDataHandler: NSObject {
    
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    class func saveExpense(sphere: String, number: Int, amount: Double) -> Bool {
        let context = CoreDataHandler.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Expenses", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(sphere, forKey: "sphere")
        manageObject.setValue(number, forKey: "number")
        manageObject.setValue(amount, forKey: "amount")
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func fetchExp() -> [Task]? {
        let context = getContext()
        var task:[Task]? = nil
        do {
            task = try context.fetch(Task.fetchRequest())
            return task
        } catch {
            return task
        }
    }
    
    class func deleteTask(task: Task) -> Bool {
        let context = getContext()
        context.delete(task)
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    class func cleanExpenses() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: Task.fetchRequest())
        
        do {
            try context.execute(delete)
            return true
        } catch {
            return false
        }
    }
}

