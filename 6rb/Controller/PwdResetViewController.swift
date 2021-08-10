//
//  PwdResetViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/21.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class PwdResetViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    

    func configureView() {
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOpacity = 0.5
    }

    @IBAction func onLogin(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
}
