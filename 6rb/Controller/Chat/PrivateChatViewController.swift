//
//  PrivateChatViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/26.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class PrivateChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var msgConView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.scrollToBottom()
    }
    
    
    func configureView() {
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        msgConView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func onClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension PrivateChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SentTextChatTableViewCell", for: indexPath) as! SentTextChatTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReceivedTextChatTableViewCell", for: indexPath) as! ReceivedTextChatTableViewCell
            return cell
        }
        
    }
    
    
}

extension PrivateChatViewController: UITableViewDelegate {
    
}
