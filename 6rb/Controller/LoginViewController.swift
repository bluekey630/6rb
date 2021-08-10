//
//  LoginViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/20.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var orView: UIView!
    @IBOutlet weak var emailConView: UIView!
    @IBOutlet weak var passwordConView: UIView!
    @IBOutlet weak var btnCheck: UIButton!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var isRemember = false
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        
        if GlobalData.myAccount.id.count > 0 {
            if GlobalData.from == "6rb" {
                let vc = storyboard?.instantiateViewController(withIdentifier: "Chat6rbLoginViewController") as! Chat6rbLoginViewController
                navigationController?.pushViewController(vc, animated: false)
            } else if GlobalData.from == "friend" {
                let vc = storyboard?.instantiateViewController(withIdentifier: "FriendChatViewController") as! FriendChatViewController
                navigationController?.pushViewController(vc, animated: false)
            } else if GlobalData.from == "pro" {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ProChatViewController") as! ProChatViewController
                navigationController?.pushViewController(vc, animated: false)
            } else if GlobalData.from == "myplaylist" {
                let vc = storyboard?.instantiateViewController(withIdentifier: "BrowsePlaylistViewController") as! BrowsePlaylistViewController
                navigationController?.pushViewController(vc, animated: false)
            } else if GlobalData.from == "mysongs" {
                let vc = storyboard?.instantiateViewController(withIdentifier: "BrowseMySongViewController") as! BrowseMySongViewController
                navigationController?.pushViewController(vc, animated: false)
            } else if GlobalData.from == "history" {
                let vc = storyboard?.instantiateViewController(withIdentifier: "BrowseHistoryViewController") as! BrowseHistoryViewController
                navigationController?.pushViewController(vc, animated: false)
            }
            
        }
        
        
    }
    
    func configureView() {
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 2
        contentView.layer.shadowOpacity = 0.5
        
        orView.layer.borderColor = UIColor.lightGray.cgColor
        emailConView.layer.borderColor = UIColor.lightGray.cgColor
        passwordConView.layer.borderColor = UIColor.lightGray.cgColor
        
    }

    @IBAction func loginWithTwitter(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") as! MainTabViewController
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginWithFacebook(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") as! MainTabViewController
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func loginWithGoogle(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "MainTabViewController") as! MainTabViewController
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onRemember(_ sender: Any) {
        isRemember = !isRemember
        isRemember ? btnCheck.setImage(UIImage(named: "ic_checked"), for: .normal) : btnCheck.setImage(UIImage(named: "ic_unchecked"), for: .normal)
    }
    
    @IBAction func onLogin(_ sender: Any) {

        //Login Function
        
        let email = txtEmail.text!
        let passowrd = txtPassword.text!
        
        if email.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Warning", msg: "Please enter your username or email.")
            return
        }
        
        if passowrd.count == 0 {
            CommonManager.shared.showAlert(viewCtrl: self, title: "Warning", msg: "Please enter password.")
            return
        }
//        else if passowrd.count < 6 {
//            CommonManager.shared.showAlert(viewCtrl: self, title: "Warning", msg: "Password should be minimum 6 charaters.")
//            return
//        }
        
        let body = [
            "user": email,
            "pwd": passowrd,
            "rememberMe" : "remember"
        ]
        
        ProgressHud.shared.show(view: view, msg: "")
        APIManager.shared.login(body: body, completion: {
            error, response in
            ProgressHud.shared.dismiss()
            if error != nil {
                CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: error!.localizedDescription)
            } else if response != nil {
                let res = response as! [String: Any]
                let status = res["status"] as! Int
                if status == 200 {
                    let data = res["data"] as! [String: Any]
                    let user = UserModel(dict: data)
                    
                    if self.isRemember {
                        UserDefaults.standard.set(data, forKey: "user-data")
                    }
                    
                    GlobalData.myAccount = user
                    
                    if GlobalData.from == "6rb" {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Chat6rbLoginViewController") as! Chat6rbLoginViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else if GlobalData.from == "friend" {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FriendChatViewController") as! FriendChatViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else if GlobalData.from == "pro" {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProChatViewController") as! ProChatViewController
                        self.navigationController?.pushViewController(vc, animated: false)
                    } else if GlobalData.from == "history" {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BrowseHistoryViewController") as! BrowseHistoryViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else if GlobalData.from == "myplaylist" {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BrowsePlaylistViewController") as! BrowsePlaylistViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else if GlobalData.from == "mysongs" {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BrowseMySongViewController") as! BrowseMySongViewController
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else if GlobalData.from == "downloads" {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-library-logined"), object: nil)
                    } else if GlobalData.from == "liked" {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-library-logined"), object: nil)
                    } else if GlobalData.from == "followers" {
                        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-library-logined"), object: nil)
                    }
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
        
        
        
    }
    
    @IBAction func onRegister(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onForgot(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        navigationController?.pushViewController(vc, animated: true)
    }
}
