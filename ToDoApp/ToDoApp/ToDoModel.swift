//
//  ToDoModel.swift
//  ToDoApp
//
//  Created by 工藤海斗 on 2020/04/06.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoModel : Object {
    @objc dynamic var title = ""
    @objc dynamic var date = ""
}
