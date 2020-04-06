//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by 工藤海斗 on 2020/04/06.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var addToDoListViewController : AddToDoListViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.isEditing = true // 並び替えや削除が可能
        if UserDefaults.standard.object(forKey: "ToDoList") != nil{
            toDoList = UserDefaults.standard.object(forKey: "ToDoList") as! [String]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(toDoList.count)
        return toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        cell.textLabel?.text = toDoList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true // trueを返すことでcellの編集を許可する
    }
    
    // cellをスワイプして削除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            toDoList.remove(at: indexPath.row)
            UserDefaults.standard.set(toDoList, forKey: "ToDoList")
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    // 並び替え
    /*override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = toDoList[sourceIndexPath.row]
        toDoList.remove(at: sourceIndexPath.row)
        toDoList.insert(todo, at: destinationIndexPath.row)
    }*/
}
