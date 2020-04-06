//
//  AddToDoListViewController.swift
//  ToDoApp
//
//  Created by 工藤海斗 on 2020/04/06.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit
var toDoList = [String]()
class AddToDoListViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func AddToDoList(_ sender: Any) {
        toDoList.append(self.textField.text!)
        print(toDoList)
        textField.text = ""
        UserDefaults.standard.set(toDoList, forKey: "ToDoList")
    }
    
}
