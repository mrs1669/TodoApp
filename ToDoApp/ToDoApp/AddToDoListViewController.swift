//
//  AddToDoListViewController.swift
//  ToDoApp
//
//  Created by 工藤海斗 on 2020/04/06.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit
import RealmSwift

//var toDoList = [String]()
class AddToDoListViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    var toDoLists : Results<ToDoModel>! //Realmから受け取るデータを入れる
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.delegate = self
        
        // RealmのTodoリストを取得
        let realm = try! Realm()
        toDoLists = realm.objects(ToDoModel.self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func AddToDoList(_ sender: Any) {
        let realm = try! Realm()
        let toDoModel:ToDoModel = ToDoModel()
        toDoModel.title = textField.text!
        
        try! realm.write({
            realm.add(toDoModel)
        })
        textField.text = ""
        
    }
    
    func cheakToDoList(completion: @escaping (Results<ToDoModel>) -> Void) {
        let realm = try! Realm()
        self.toDoLists = realm.objects(ToDoModel.self)
        completion(self.toDoLists)
    }
}
