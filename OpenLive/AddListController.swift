//
//  AddListController.swift
//  OpenLive
//
//  Created by Zhangchengbin on 2017/8/7.
//  Copyright © 2017年 Agora. All rights reserved.
//

import UIKit
import CoreData

class AddListController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mySelectedImageView: UIImageView!
    
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
        
//        navigationItem.title = "Add A List"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add in done buttom to the top right
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(handleDone))
    }
    
    func handleDone() {
        print("Handling done...")
        print("Name: \(nameTextField.text)")
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let list = NSEntityDescription.insertNewObject(forEntityName: "List", into: context)
        let buttonImage = mySelectedImageView.image
        let binaryData = UIImageJPEGRepresentation(buttonImage!, 1)
        list.setValue(binaryData, forKey: "picData")
        
        //we will save mentor
        list.setValue(nameTextField.text, forKey: "name")
        
        //finally we will save it into coredata
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch let err{
            print("Fail to save", err)
        }
        
        
    }
    

    

    @IBAction func addButton(_ sender: Any) {
        //textfield content
        //
        navigationController?.popViewController(animated: true)
        
    }
//    var listscontroller: ListsController?
    
//    func handleDone() {
//        print("Name: \(nameTextField.text)")
//
//        
//        //nameTextField.text ?? ""
//        let addedList = List(name: nameTextField.text ?? "", imageName: "")
//        self.listscontroller?.didFinishAddingMentor(list: addedList)
//        navigationController?.popViewController(animated: true)
//
//        
//    }
    

    @IBAction func showImageSelector(_ sender: Any) {
        print("Lets show image selector")
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // in the case of an edited image, we use key "UIImagePickerControllerEditedImage"
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            
            mySelectedImageView.image = editedImage
            
            
            
        } else {
            
            let image = info["UIImagePickerControllerOriginalImage"] as? UIImage
            mySelectedImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    


    

}
