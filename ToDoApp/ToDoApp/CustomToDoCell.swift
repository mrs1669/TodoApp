//
//  CustomToDoCell.swift
//  ToDoApp
//
//  Created by 工藤海斗 on 2020/04/23.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit
import RealmSwift

class CustomToDoCell: UITableViewCell {
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    var toDoLists : Results<ToDoModel>! //Realmから受け取るデータを入れる
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func checkButton(_ sender: CheckBox) {
        print(sender.isChecked)
        
        /*let realm = try! Realm()
        let toDoModel:ToDoModel = ToDoModel()
        toDoModel.isChecked = sender.isChecked
        try! realm.write({
            realm.add(toDoModel)
        })*/
    }
    
    func setToDoCell(todoList : String, date : String){
        toDoLabel.text? = todoList
        dateLabel.text? = date
    }
}
