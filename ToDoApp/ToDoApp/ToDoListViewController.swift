//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by 工藤海斗 on 2020/04/06.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

class ToDoListViewController: UITableViewController {
    
    var addToDoListViewController = AddToDoListViewController()
    var toDoLists : Results<ToDoModel>! //Realmから受け取るデータを入れる
    var observable : Observable<String>!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(Realm.Configuration.defaultConfiguration.fileURL!) // realmファイルのパスを取得してrealm blowserで確認
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
        return self.toDoLists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath)
        cell.textLabel?.text = self.toDoLists?[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true // trueを返すことでcellの編集を許可する
    }
    
    // cellをスワイプして削除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            
            let realm = try! Realm()
            try! realm.write({
                realm.delete(self.toDoLists[indexPath.row])
            })
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            print(self.toDoLists as Any)
        }
    }
}
