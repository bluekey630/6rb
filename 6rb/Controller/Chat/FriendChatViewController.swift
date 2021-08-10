//
//  FriendChatViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/26.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class FriendChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    

    func configureView() {
        
    }

}

extension FriendChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendChatRoomTableViewCell", for: indexPath) as! FriendChatRoomTableViewCell
        cell.onlineView.layer.borderColor = UIColor.white.cgColor
        return cell
    }
}

extension FriendChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        let vc = storyboard?.instantiateViewController(withIdentifier: "PrivateChatViewController") as! PrivateChatViewController
        present(vc, animated: true, completion: nil)
    }
    
}
