//
//  AddToDoListViewController.swift
//  ToDoApp
//
//  Created by 工藤海斗 on 2020/04/06.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift

//var toDoList = [String]()
class AddToDoListViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    var toDoLists : Results<ToDoModel>! //Realmから受け取るデータを入れる
    var observable:Observable<String>!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.delegate = self
        textField.placeholder = "ToDoリストに追加したいことを入力してください"
        
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
        
        toDoModel.title = self.textField.text!
        
        try! realm.write({ // データベースへの書き込み
            realm.add(toDoModel)
        })
        
        textField.text = ""
    }
    
    func newCheckToDoList() -> Observable<Results<ToDoModel>>{
        return Observable.create({ observer in
            let realm = try! Realm()
            self.toDoLists = realm.objects(ToDoModel.self)
            observer.onNext(self.toDoLists)
            observer.onCompleted()
            return Disposables.create()
        })
    }
    
}
