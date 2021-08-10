//
//  RegisterViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/20.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var userConView: UIView!
    @IBOutlet weak var emailConView: UIView!
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
        
        userConView.layer.borderColor = UIColor.lightGray.cgColor
        emailConView.layer.borderColor = UIColor.lightGray.cgColor
        passwordConView.layer.borderColor = UIColor.lightGray.cgColor
        confirmConView.layer.borderColor = UIColor.lightGray.cgColor
        
    }

    @IBAction func onRegister(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") as! MainTabViewController
//        navigationController?.pushViewController(vc, animated: true)
        GlobalData.isLogin = true
        
        if GlobalData.from == "6rb" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "Chat6rbLoginViewController") as! Chat6rbLoginViewController
            navigationController?.pushViewController(vc, animated: true)
        } else if GlobalData.from == "friend" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "FriendChatViewController") as! FriendChatViewController
            navigationController?.pushViewController(vc, animated: true)
        } else if GlobalData.from == "pro" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProChatViewController") as! ProChatViewController
            navigationController?.pushViewController(vc, animated: false)
        } else if GlobalData.from == "myplaylist" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "BrowsePlaylistViewController") as! BrowsePlaylistViewController
            navigationController?.pushViewController(vc, animated: true)
        } else if GlobalData.from == "mysongs" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "BrowseMySongViewController") as! BrowseMySongViewController
            navigationController?.pushViewController(vc, animated: true)
        } else if GlobalData.from == "downloads" {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "open-library-logined"), object: nil)
        } else if GlobalData.from == "liked" {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "open-library-logined"), object: nil)
        } else if GlobalData.from == "followers" {
            NotificationCenter.default.post(name: Notification.Name(rawValue: "open-library-logined"), object: nil)
        }
    }
    
    @IBAction func onLoginHere(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
