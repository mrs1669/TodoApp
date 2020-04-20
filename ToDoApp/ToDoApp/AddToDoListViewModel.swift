//
//  AddToDoListViewModel.swift
//  ToDoApp
//
//  Created by 工藤海斗 on 2020/04/20.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

class AddToDoListViewModel {
    private var toDoLists : Results<ToDoModel>! //Realmから受け取るデータを入れる
    
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
