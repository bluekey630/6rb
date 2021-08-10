//
//  LikedLibViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/27.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class LikedLibViewController: UIViewController {

    @IBOutlet weak var songSel: UIView!
    @IBOutlet weak var btnSong: UIButton!
    
    @IBOutlet weak var playlistSel: UIView!
    @IBOutlet weak var btnPlaylist: UIButton!
    
    @IBOutlet weak var userSel: UIView!
    @IBOutlet weak var btnUsers: UIButton!
    
    @IBOutlet weak var songConView: UIView!
    @IBOutlet weak var playlistConView: UIView!
    @IBOutlet weak var userConView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    

    func configureView() {
        songSel.isHidden = false
        btnSong.setTitleColor(UIColor.black, for: .normal)
        
        playlistSel.isHidden = true
        btnPlaylist.setTitleColor(UIColor.lightGray, for: .normal)
        
        userSel.isHidden = true
        btnUsers.setTitleColor(UIColor.lightGray, for: .normal)
        
        songConView.isHidden = false
        playlistConView.isHidden = true
        userConView.isHidden = true
    }

    @IBAction func onSong(_ sender: Any) {
        songSel.isHidden = false
        btnSong.setTitleColor(UIColor.black, for: .normal)
        
        playlistSel.isHidden = true
        btnPlaylist.setTitleColor(UIColor.lightGray, for: .normal)
        
        userSel.isHidden = true
        btnUsers.setTitleColor(UIColor.lightGray, for: .normal)
        
        songConView.isHidden = false
        playlistConView.isHidden = true
        userConView.isHidden = true
    }
    
    @IBAction func onPlaylist(_ sender: Any) {
        songSel.isHidden = true
        btnSong.setTitleColor(UIColor.lightGray, for: .normal)
        
        playlistSel.isHidden = false
        btnPlaylist.setTitleColor(UIColor.black, for: .normal)
        
        userSel.isHidden = true
        btnUsers.setTitleColor(UIColor.lightGray, for: .normal)
        
        songConView.isHidden = true
        playlistConView.isHidden = false
        userConView.isHidden = true
    }
    
    @IBAction func onUsers(_ sender: Any) {
        songSel.isHidden = true
        btnSong.setTitleColor(UIColor.lightGray, for: .normal)
        
        playlistSel.isHidden = true
        btnPlaylist.setTitleColor(UIColor.lightGray, for: .normal)
        
        userSel.isHidden = false
        btnUsers.setTitleColor(UIColor.black, for: .normal)
        
        songConView.isHidden = true
        playlistConView.isHidden = true
        userConView.isHidden = false
    }
}

extension LikedLibViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
}

extension LikedLibViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 100 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
            return cell
        } else if tableView.tag == 200 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell", for: indexPath) as! PlaylistTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            return cell
        }
    }
    
    
}


