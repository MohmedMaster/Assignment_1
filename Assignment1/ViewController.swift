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

      @IBOutlet private weak var displayNameLabel: UILabel!
      @IBOutlet private weak var inputTextField: UITextField!
      @IBOutlet private weak var numberTextField: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        //Calling entity
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        //Add Data
        newUser.setValue("\(inputTextField.text ?? "")", forKey: "name")
        
        //Save data
        do {
            try context.save()
            inputTextField.text = ""
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            
            do{
                let result = try context.fetch(request)
                numberTextField.text = result.count.description
            }catch {
            }
            
        } catch let error{
            print("Failed! Could Not Save \(error)")
        }
    }
    
    @IBAction func retrieveButtonTapped(_ sender: Any) {
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
                displayNameLabel.text = name
            }
            
        } catch {
            print ("Failed To Read")
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        let alert = UIAlertController( title: NSLocalizedString("LABEL_QUESTION_TEXT", comment: "Question"), message: nil, preferredStyle: .alert)
   
        alert.addAction(UIAlertAction(title: NSLocalizedString("CANCEL_BUTTON_TEXT", comment: "NO"), style: .cancel, handler: nil))
   
        alert.addAction(UIAlertAction(title: NSLocalizedString("CONFIRM_BUTTON_TEXT", comment: "YES"), style: .default, handler: nil ))
   
        present(alert, animated: true)
        /*let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.returnsObjectsAsFaults = false
        
        do {
            var number = 0
            
            let result = try context.fetch(request)
            
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
                context.delete(data)
                lblText.text = ""
                number = result.count - 1
//                guard  let name = data.value(forKey: "name") as? String
                do {
                    try context.save()
                } catch {}
            }
            numberTextField.text = number.description
        } catch {
            print ("Failed To Read")
        }*/
    }
}
