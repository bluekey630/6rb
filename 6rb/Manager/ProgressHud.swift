//
//  ProgressHud.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/21.
//  Copyright © 2019 6rb. All rights reserved.
//

import Foundation
import JGProgressHUD
import UIKit

class ProgressHud {
    static let shared = ProgressHud()
    let hud = JGProgressHUD(style: .light)
    
    private init() {}
    
    func show(view: UIView, msg: String) {
        hud.textLabel.text = msg
        hud.show(in: view)
    }
    
    func dismiss() {
        //hud.dismiss(afterDelay: 3.0)
        hud.dismiss()
    }
    
}
