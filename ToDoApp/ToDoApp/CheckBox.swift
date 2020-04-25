//
//  CheckBox.swift
//  ToDoApp
//
//  Created by 工藤海斗 on 2020/04/22.
//  Copyright © 2020 工藤海斗. All rights reserved.
//

import UIKit

class CheckBox: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    // Images
    let checkedImage = UIImage(named: "check_on")! as UIImage // 選択済み
    let uncheckedImage = UIImage(named: "check_off")! as UIImage // 未選択
    
    // Bool property
    var isChecked : Bool = false {
        didSet{ // isCheckedが変更された後に呼ばれる処理
            if isChecked == true{
                self.setImage(checkedImage, for: UIControl.State.normal)
            }
            else{
                self.setImage(uncheckedImage, for: UIControl.State.normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControl.Event.touchUpInside)
        self.isChecked = false
    }
    
    @objc func buttonClicked(sender : UIButton){
        if sender == self{
            isChecked = !isChecked
        }
    }
}

