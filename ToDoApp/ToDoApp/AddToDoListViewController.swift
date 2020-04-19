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

class AddToDoListViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateLabel: UILabel!
    let currentDateFormatter = DateFormatter()
    var toDoLists : Results<ToDoModel>! //Realmから受け取るデータを入れる
    var observable:Observable<String>!
    let disposeBag = DisposeBag()
    //var calendar = Calendar(identifier: .gregorian)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentDateFormatter.dateFormat = /*DateFormatter.dateFormat(fromTemplate: */"yyyy/MM/dd  HH:mm"/*, options: 0, locale: Locale(identifier: "ja_JP"))*/
        textField.delegate = self
        textField.placeholder = "ToDoリストに追加したいことを入力してください"
        //checkButton.isEnabled = false
        // RealmのTodoリストを取得
        let realm = try! Realm()
        toDoLists = realm.objects(ToDoModel.self)
        datePicker.locale = Locale(identifier: "ja_JP")
        dateLabel.text = currentDateFormatter.string(from: Date())
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if textField.text == ""{
            checkButton.isEnabled = false
        }
        else{
            checkButton.isEnabled = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text == ""{
            checkButton.isEnabled = false
        }
        else{
            checkButton.isEnabled = true
        }
        return true
    }
    
    @IBAction func tapLabel(_ sender: Any) {
        
    }
    
    @IBAction func AddToDoList(_ sender: Any) {
        
        let realm = try! Realm()
        let toDoModel:ToDoModel = ToDoModel()
        
        toDoModel.title = self.textField.text!
        toDoModel.date = self.format(date: datePicker.date)
        try! realm.write({ // データベースへの書き込み
            realm.add(toDoModel)
        })
        
        //let formatter = DateFormatter()
        //formatter.dateFormat = "yyyy-MM-dd"
        //textField.text = "\(formatter.string(from: datePicker.date))"
        
        textField.text = ""
        textField.placeholder = "ToDoリストに追加したいことを入力してください"
        checkButton.isEnabled = false
    }
    
    @IBAction func dateChanged(_ sender: Any) {
        dateLabel.text = self.format(date: datePicker.date)
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
    
    // UIDatePickerViewから年月日・日時を取得
    func format(date:Date)->String{
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy/MM/dd  HH:mm"
        let strDate = dateformatter.string(from: date)
        
        return strDate
    }
    
}
