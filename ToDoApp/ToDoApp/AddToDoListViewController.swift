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
        
        writeRealm().subscribe(onNext : { title in
            print(title)
        }, onError : { error in
            print(error)
        }, onCompleted:{
            print("completed")
        }, onDisposed: {
            print("disposed")
        }).disposed(by: disposeBag)
        
        textField.text = ""
        
    }
    
    func cheakToDoList(completion: @escaping (Results<ToDoModel>) -> Void) {
        let realm = try! Realm()
        self.toDoLists = realm.objects(ToDoModel.self)
        completion(self.toDoLists)
    }
    
    // この中で将来はRxSwiftを使う
    func writeRealm() -> Observable<String> {
        return Observable.create({ observer in
            let realm = try! Realm()
            let toDoModel:ToDoModel = ToDoModel()
            toDoModel.title = self.textField.text!
            
            try! realm.write({
                realm.add(toDoModel)
                observer.onNext(toDoModel.title)
                observer.onCompleted()
            })
            return Disposables.create()
            })
        /*let realm = try! Realm()
        let toDoModel:ToDoModel = ToDoModel()
        toDoModel.title = textField.text!*/
        
        /*try! realm.write({
            realm.add(toDoModel)
            observable = Observable.of(toDoModel.title)
        })*/
        
        /*observable.subscribe(onNext:{ element in
            print(element)
        }, onError:{ error in
            print(error)
        }, onCompleted:{
            print("completed")
        }).disposed(by: disposeBag)*/
        
    }
}
