//
//  CalendarViewModel.swift
//  ToDoApp
//
//  Created by 工藤海斗 on 2020/04/19.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import Foundation
import FSCalendar
import CalculateCalendarLogic
import RxSwift
import RealmSwift

class CalendarViewModel {
    //祝日判定用のカレンダークラスのインスタンス
    private let tmpCalendar = Calendar(identifier: .gregorian)
    private let dateformatter = DateFormatter()
    private var toDoLists : Results<ToDoModel>!
    // 祝日判定を行い結果を返すメソッド(True:祝日)
    func judgeHoliday(date : Date) -> Bool{
         // 祝日判定を行う日にちの年、月、日を取得
        let year = tmpCalendar.component(.year, from: date)
        let month = tmpCalendar.component(.month, from: date)
        let day = tmpCalendar.component(.day, from: date)
        
        // CalculateCalendarLogic()：祝日判定のインスタンスの生成
        let holiday = CalculateCalendarLogic()
        
        return holiday.judgeJapaneseHoliday(year: year, month: month, day: day)
    }
    
    // 曜日判定(日曜日:1 〜 土曜日:7)
    func getWeekIndex(date : Date) -> Int{
        return tmpCalendar.component(.weekday, from: date)
    }
    
    // Date型 -> 年
    func getYear(date : Date) -> String{
        dateformatter.dateFormat = "YYYY"
        let strYear = dateformatter.string(from: date)
        return strYear
    }
    
    // Date型 -> 月
    func getMonth(date : Date) -> String{
        dateformatter.dateFormat = "MM"
        let strMonth = dateformatter.string(from: date)
        return strMonth
    }
    
    // Date型 -> 日
    func getDay(date : Date) -> String{
        dateformatter.dateFormat = "dd"
        let strDay = dateformatter.string(from: date)
        return strDay
    }
    
    // タップされたカレンダーの日付を受け取って、Realmに問い合わせをする。
    // 日付で格納させているデータを検索して、ヒットしたリストを返す
    func searchToDoList(date : Date) -> Results<ToDoModel>{
        let realm = try! Realm()
        self.toDoLists = realm.objects(ToDoModel.self)
        let todayFilter = "\(self.getYear(date: date))/\(self.getMonth(date: date))/\(self.getDay(date: date))"
        self.toDoLists = self.toDoLists.filter("date LIKE '\(todayFilter)*' ")
        
        return toDoLists
    }
}
