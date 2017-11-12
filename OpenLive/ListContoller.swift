//
//  listTableViewCell.swift
//  OpenLive
//
//  Created by Zhangchengbin on 2017/8/7.
//  Copyright © 2017年 Agora. All rights reserved.
//

import UIKit
import CoreData

class ListsController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //we are goiong to now fetch all of our moentors that we save
        let fetchRequest = NSFetchRequest<List>(entityName: "List")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            lists = try context.fetch(fetchRequest)
            for list in lists {
                print(list.name, list.picData)
            }
        } catch let err {
            print("Failed to fetch lists:", err)
        }
        
    }
    var lists = [List]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)as?
        CustomListCell
        
        cell?.backgroundColor = .white

        
        let list = lists[indexPath.row]
        cell?.nameLabel.text = list.name
        let image = UIImage(data: list.picData as! Data)
        cell?.imageCoverView.image = image
        
        return cell!
    }
    
    func fetchLists(){
        let fetchRequest = NSFetchRequest<List>(entityName: "List")
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            lists = try context.fetch(fetchRequest)
            for list in lists {
                print(list.name, list.picData)
            }
        } catch let err {
            print("Failed to fetch mentors:", err)
        }
        
        //the first 5 mentors we save here have no title,detail,date
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLists()
        tableView.reloadData()
    }
    
    func didFinishAddingList(list: List) {
        
        lists.append(list)
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(lists[indexPath.row])
            do {
                try context.save()
                lists.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                
            } catch let err {
                print("Failed to delete:", err)
            }

        }
    }
  

}
