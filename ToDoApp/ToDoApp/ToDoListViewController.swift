//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by 工藤海斗 on 2020/04/06.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {
    
    var addToDoListViewController = AddToDoListViewController()
    var toDoLists : Results<ToDoModel>! //Realmから受け取るデータを入れる
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        /*if UserDefaults.standard.object(forKey: "ToDoList") != nil{
            toDoList = UserDefaults.standard.object(forKey: "ToDoList") as! [String]
        }*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addToDoListViewController.cheakToDoList(completion: { toDoLists in
            self.toDoLists = toDoLists
            print(self.toDoLists as Any)
        })
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*print(toDoList.count)
        return toDoList.count*/
        //print(addToDoListViewController.toDoLists?.count as Any)
        return self.toDoLists.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        //cell.textLabel?.text = toDoList[indexPath.row]
        cell.textLabel?.text = self.toDoLists?[indexPath.row].title
        //print(addToDoListViewController.toDoLists?[indexPath.row] as Any)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true // trueを返すことでcellの編集を許可する
    }
    
    // cellをスワイプして削除
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            toDoList.remove(at: indexPath.row)
            UserDefaults.standard.set(toDoList, forKey: "ToDoList")
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }*/
}
