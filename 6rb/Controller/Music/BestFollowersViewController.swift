//
//  BestFollowersViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/18.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class BestFollowersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dropDate: DropDown!
    
    var users: [UserModel] = []
    var date: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        date = "week"
        getFollowers()
    }
    
    func configureView() {
        dropDate.optionArray = ["WEEK", "MONTH", "YEAR"]
        dropDate.selectValue(index: 0)
        dropDate.didSelect(completion: {selectedText, index, id in
            print(selectedText, index, id)
        })
        
        dropDate.delegate = self
        
        tableView.isHidden = true
    }
    
    func getFollowers() {
        APIManager.shared.getBestFollowers(more: true, date: date, completion: {
            error, response in
            if error != nil {
                //                print(error!.localizedDescription)//
                CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: error!.localizedDescription)
            } else {
                let res = response as! [String: Any]
                let code = res["status"] as! Int
                if code == 200 {
                    let list = res["data"] as! [Any]
                    for l in list {
                        let u = UserModel(dict: l as! [String: Any])
                        self.users.append(u)
                    }
                    
                    self.tableViewHeight.constant = CGFloat(90 * self.users.count)
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }
    
    @objc func btnMainTapped(sender: UIButton) {
        //        let index = sender.tag
        
        
    }
    
    
}

extension BestFollowersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension BestFollowersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        cell.lblName.text = user.name
        cell.lblLikeCnt.text = "\(user.like_cnt)"
        return cell
        
    }
}

extension BestFollowersViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        dropDate.isSelected ?  dropDate.hideList() : dropDate.showList()
        return false
    }
}
