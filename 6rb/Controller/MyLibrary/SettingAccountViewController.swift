//
//  SettingAccountViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/27.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class SettingAccountViewController: UIViewController {

    @IBOutlet weak var conView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    

    func configureView() {
        conView.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func onBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
