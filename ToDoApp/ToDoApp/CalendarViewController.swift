//
//  CalendarViewController.swift
//  ToDoApp
//
//  Created by 工藤海斗 on 2020/04/19.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit
import RealmSwift
import RxSwift
import FSCalendar
import CalculateCalendarLogic

class CalendarViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var todayScheduleTableView: UITableView!
    let calendarViewModel = CalendarViewModel()
    let dayOfTheWeeks = ["日":0, "月":1, "火":2, "水":3, "木":4, "金":5, "土":6]
    var toDoLists : Results<ToDoModel>!
    var addToDoListViewController = AddToDoListViewController()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        calendar.delegate = self
        calendar.dataSource = self
        calendar.appearance.headerDateFormat = "yyyy年MM月"
        
        for (key, value) in self.dayOfTheWeeks {
            self.calendar.calendarWeekdayView.weekdayLabels[value].text = key
        }
        
        // RealmのTodoリストを取得
        let realm = try! Realm()
        toDoLists = realm.objects(ToDoModel.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    // 土日・祝日の文字色を変える
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        //祝日判定をする（祝日は赤色で表示する）
        if self.calendarViewModel.judgeHoliday(date: date){
            return UIColor.red
        }
        //土日の判定を行う（土曜日は青色、日曜日は赤色で表示する）
        let weekDay = self.calendarViewModel.getWeekIndex(date: date)
        if weekDay == 1 { // 日曜日
            return UIColor.red
        }
        else if weekDay == 7 { // 土曜日
            return UIColor.blue
        }
        
        return nil
    }
    
    // カレンダーのタップイベント
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        // RealmのTodoリストを取得
        let realm = try! Realm()
        toDoLists = realm.objects(ToDoModel.self)
        let todayFilter = "\(calendarViewModel.getYear(date: date))/\(calendarViewModel.getMonth(date: date))/\(calendarViewModel.getDay(date: date))"
        print(todayFilter)
        toDoLists = toDoLists.filter("date LIKE '\(todayFilter)*' ")
        print(toDoLists)
        
    }
    
}
