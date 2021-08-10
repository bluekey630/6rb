//
//  FollowersLibViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/27.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class FollowersLibViewController: UIViewController {

    @IBOutlet weak var followersSel: UIView!
    @IBOutlet weak var btnFollowers: UIButton!
    
    @IBOutlet weak var followingSel: UIView!
    @IBOutlet weak var btnFollowing: UIButton!
    
    @IBOutlet weak var followersConView: UIView!
    @IBOutlet weak var followingConView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    

    func configureView() {
        followersSel.isHidden = false
        btnFollowers.setTitleColor(UIColor.black, for: .normal)
        
        followingSel.isHidden = true
        btnFollowing.setTitleColor(UIColor.lightGray, for: .normal)
        
        followersConView.isHidden = false
        followingConView.isHidden = true
    }

    @IBAction func onFollowers(_ sender: Any) {
        followersSel.isHidden = false
        btnFollowers.setTitleColor(UIColor.black, for: .normal)
        
        followingSel.isHidden = true
        btnFollowing.setTitleColor(UIColor.lightGray, for: .normal)
        
        followersConView.isHidden = false
        followingConView.isHidden = true
    }
    
    @IBAction func onFollowing(_ sender: Any) {
        followersSel.isHidden = true
        btnFollowers.setTitleColor(UIColor.lightGray, for: .normal)
        
        followingSel.isHidden = false
        btnFollowing.setTitleColor(UIColor.black, for: .normal)
        
        followersConView.isHidden = true
        followingConView.isHidden = false
    }
}

extension FollowersLibViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
}

extension FollowersLibViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 100 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            return cell
        }
    }
    
    
}



