//
//  ViewController.swift
//  Assignment1
//
//  Created by Mohmed Master on 2021/02/10.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext

      @IBOutlet private weak var DisplayNameLabel: UILabel!
      @IBOutlet private weak var InputTextField: UITextField!
      @IBOutlet private weak var NumberTextField: UITextField!
    
    @IBAction func SaveButtonTapped(_ sender: Any) {
        //Calling entity
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        //Add Data
        newUser.setValue("\(self.InputTextField.text ?? "")", forKey: "name")
        
        //Save data
        do {
            try context.save()
            InputTextField.text = ""
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            
            do{
                let result = try context.fetch(request)
                NumberTextField.text = result.count.description
            }catch {
            }
            
        } catch let error{
            print("Failed! Could Not Save \(error)")
        }
    }
    
    @IBAction func RetrieveButtonTapped(_ sender: Any) {
        //Retrieve Data from coreData
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
                guard  let name = data.value(forKey: "name") as? String
                else {
                    return
                }
                self.DisplayNameLabel.text = name
            }
            
        } catch {
            print ("Failed To Read")
        }
    }
    
    @IBAction func DeleteButtonTapped(_ sender: Any) {
        //Retrieve Data from coreData
        let alert = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: .alert)
   
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
   
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: nil ))
   
        self.present(alert, animated: true)
        /*let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.returnsObjectsAsFaults = false
        
        do {
            var number = 0
            
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
                self.context.delete(data)
                lblText.text = ""
                number = result.count - 1
//                guard  let name = data.value(forKey: "name") as? String
                do {
                    try self.context.save()
                } catch {}
            }
            txtNumber.text = number.description
        } catch {
            print ("Failed To Read")
        }*/
    }
}
