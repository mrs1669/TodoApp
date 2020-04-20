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

class CalendarViewModel {
    //祝日判定用のカレンダークラスのインスタンス
    private let tmpCalendar = Calendar(identifier: .gregorian)
    let dateformatter = DateFormatter()
    
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
        //let year = tmpCalendar.component(.year, from: date)
        return strYear
    }
    
    // Date型 -> 月
    func getMonth(date : Date) -> String{
        dateformatter.dateFormat = "MM"
        let strMonth = dateformatter.string(from: date)
        //let month = tmpCalendar.component(.month, from: date)
        return strMonth
    }
    
    // Date型 -> 日
    func getDay(date : Date) -> String{
        //let day = tmpCalendar.component(.day, from: date)
        dateformatter.dateFormat = "dd"
        let strDay = dateformatter.string(from: date)
        return strDay
    }
}
