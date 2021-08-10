//
//  ChatViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/23.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import Firebase
import MaterialComponents.MaterialActionSheet

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var msgConView: UIView!
    @IBOutlet weak var txtMessage: UITextField!
    
    var messages: [AdminChatModel] = []
    var users: [String: UserModel] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getChatData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        tableView.scrollToBottom()
    }
    

    func configureView() {
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        msgConView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func getChatData() {
//        ProgressHud.shared.show(view: view, msg: "")
        Database.database().reference().child("Admin").queryOrdered(byChild: "created").observe(.childAdded, with: {
            snapchat in
            ProgressHud.shared.dismiss()
            if snapchat.exists() {
                let docs = snapchat.value as! [String: Any]
                let message = AdminChatModel(dict: docs)
                message.id = snapchat.key
                if (Int(Date().timeIntervalSince1970) - message.created) < 24 * 3600 {
                    self.getUserData(message: message)
                }
                
            }
        })
    }
    
    func getUserData(message: AdminChatModel) {
        if message.user_id == GlobalData.myAccount.id || message.user_id == "Admin" {
            
            messages.append(message)
            messages = messages.sorted(by: { $0.created < $1.created })
            tableView.reloadData()
            tableView.scrollToBottom()
        } else {
            APIManager.shared.getUserInfo(id: message.user_id, completion: {
                error, response in
                
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    let res = response as! [String: Any]
                    let code = res["status"] as! Int
                    if code == 200 {
                        let user = UserModel(dict: res["data"] as! [String: Any])
                        self.users[message.user_id] = user
                        self.messages.append(message)
                        self.messages = self.messages.sorted(by: { $0.created < $1.created })
                        self.tableView.reloadData()
                        self.tableView.scrollToBottom()
                    }
                    
                }
            })
        }
    }
    
    
    @IBAction func onSend(_ sender: Any) {
        
        let messsage = txtMessage.text!
        if messsage.count > 0 {
            let body: [String: Any] = [
                "content": messsage,
                "user_id": GlobalData.myAccount.id,
                "photo_url": "",
                "created": Int(Date().timeIntervalSince1970)
            ]
            
            Database.database().reference().child("Admin").childByAutoId().setValue(body)
            txtMessage.text = ""
        }
    }
    
    @IBAction func onAttatch(_ sender: Any) {
        let actionSheet = MDCActionSheetController(title: "", message: "")
        
        let actionCamera = MDCActionSheetAction(title: "Camera", image: UIImage(named: "ic_camera_alert"), handler: {
            action in
            print("Clicked Camera")
        })
        
        let actionPhoto = MDCActionSheetAction(title: "Photo Library", image: UIImage(named: "ic_photo_alert"), handler: {
            action in
            print("Clicked Photo Library")
        })
        
        let actionVideo = MDCActionSheetAction(title: "Video Library", image: UIImage(named: "ic_video_alert"), handler: {
            action in
            print("Clicked Video Library")
        })
        
       
        
        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionPhoto)
        actionSheet.addAction(actionVideo)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func onClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        if message.user_id == GlobalData.myAccount.id {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SentTextChatTableViewCell", for: indexPath) as! SentTextChatTableViewCell
            cell.lblMessage.text = message.content
            cell.lblName.text = "You"
            cell.imgAvatar.kf.setImage(with: URL(string: GlobalData.myAccount.avatar)!, placeholder: UIImage(named: "unknown_user"))
            cell.lblTime.text = CommonManager.shared.getTime(timestamp: Int64(message.created))
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedTextChatTableViewCell", for: indexPath) as! ReceivedTextChatTableViewCell
            cell.lblMessage.text = message.content
            
            if message.user_id == "Admin" {
                cell.lblName.text = "Admin - 6rb Team"
                cell.lblName.textColor = UIColor.white
                cell.lblTime.text = CommonManager.shared.getTime(timestamp: Int64(message.created))
                cell.lblTime.textColor = UIColor.white
                cell.imgBubble.tintColor = UIColor.red
                cell.lblMessage.textColor = UIColor.white
                
                cell.imgAvatar.image = UIImage(named: "ic_6rb_chat_logo")
            } else {
                let user = users[message.user_id]!
                cell.imgBubble.tintColor = UIColor.white
                cell.lblName.text = user.name
                cell.lblName.textColor = UIColor(red: 241/255, green: 156/255, blue: 69/255, alpha: 1)
                cell.lblTime.text = CommonManager.shared.getTime(timestamp: Int64(message.created))
                cell.lblTime.textColor = UIColor.darkGray
                cell.lblMessage.textColor = UIColor.darkGray
                
                let avatarUrl = URL(string: user.avatar)
                if avatarUrl != nil {
                    cell.imgAvatar.kf.setImage(with: avatarUrl!, placeholder: UIImage(named: "unknown_user"))
                } else {
                    cell.imgAvatar.image = UIImage(named: "unknown_user")
                }
            }
            
            return cell
        }
       
    }
}

extension ChatViewController: UITableViewDelegate {
    
}
