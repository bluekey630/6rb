//
//  ChangePwdViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/21.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class ChangePwdViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var passwordConView: UIView!
    @IBOutlet weak var confirmConView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    

    func configureView() {
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOpacity = 0.5
        
        passwordConView.layer.borderColor = UIColor.lightGray.cgColor
        confirmConView.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func onSave(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PwdResetViewController") as! PwdResetViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
