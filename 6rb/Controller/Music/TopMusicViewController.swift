//
//  TopMusicViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/11.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import AVKit

class TopMusicViewController: UIViewController {

    @IBOutlet weak var dropDate: DropDown!
    
    @IBOutlet weak var bestSongView: UIView!
    @IBOutlet weak var bestPlaylistView: UIView!
    @IBOutlet weak var bestLikeUserView: UIView!
    @IBOutlet weak var bestFollowerUserView: UIView!
    
    @IBOutlet weak var bestSongTableView: UITableView!
    @IBOutlet weak var bestSongTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bestPlaylistTableView: UITableView!
    @IBOutlet weak var bestPlaylistTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bestLikeUserTableView: UITableView!
    @IBOutlet weak var bestLikeUserTableHeight: NSLayoutConstraint!
    
    @IBOutlet weak var bestFollowerUserTableView: UITableView!
    @IBOutlet weak var bestFollowerUserTableHeight: NSLayoutConstraint!
    
    var getInfoCnt = 0
    
    var bestSongs: [MusicModel] = []
    var bestPlaylist: [PlaylistModel] = []
    var bestLikeUsers: [UserModel] = []
    var bestFollowerUsers: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        self.getBestSongs(date: "week")
        self.getBestPlaylist(date: "week")
        self.getBestLikeUser(date: "week")
        self.getBestFollowerUser(date: "week")
    }
    

    func configureView() {
        dropDate.optionArray = ["WEEK", "MONTH", "YEAR"]
        dropDate.selectValue(index: 0)
        dropDate.didSelect(completion: {selectedText, index, id in
            print(selectedText, index, id)
            let date = selectedText.lowercased()
            print("date:\(date)")
            self.getBestSongs(date: date)
            self.getBestPlaylist(date: date)
            self.getBestLikeUser(date: date)
            self.getBestFollowerUser(date: date)
        })
        
        dropDate.delegate = self
        
        bestSongView.isHidden = true
        bestPlaylistView.isHidden = true
        bestLikeUserView.isHidden = true
        bestFollowerUserView.isHidden = true
    }
    
    func getBestSongs(date: String) {
        bestSongs = []
        APIManager.shared.getBestSongs(more: false, date: date, completion: {
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
                        let music = MusicModel(dict: l as! [String: Any])
                        self.bestSongs.append(music)
                    }
                    
                    self.bestSongTableHeight.constant = CGFloat(90 * self.bestSongs.count)
                    self.bestSongTableView.reloadData()
                    self.bestSongView.isHidden = false
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }
    
    func getBestPlaylist(date: String) {
        bestPlaylist = []
        APIManager.shared.getBestPlaylist(more: false, date: date, completion: {
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
                        let p = PlaylistModel(dict: l as! [String: Any])
                        self.bestPlaylist.append(p)
                    }
                    
                    self.bestPlaylistTableHeight.constant = CGFloat(90 * self.bestPlaylist.count)
                    self.bestPlaylistTableView.reloadData()
                    self.bestPlaylistView.isHidden = false
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }
    
    func getBestLikeUser(date: String) {
        bestLikeUsers = []
        APIManager.shared.getBestLikeUsers(more: false, date: date, completion: {
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
                        let user = UserModel(dict: l as! [String: Any])
                        self.bestLikeUsers.append(user)
                    }
                    
                    self.bestLikeUserTableHeight.constant = CGFloat(90 * self.bestLikeUsers.count)
                    self.bestLikeUserTableView.reloadData()
                    self.bestLikeUserView.isHidden = false
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }
    
    func getBestFollowerUser(date: String) {
        bestFollowerUsers = []
        APIManager.shared.getBestLikeUsers(more: false, date: date, completion: {
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
                        let user = UserModel(dict: l as! [String: Any])
                        self.bestFollowerUsers.append(user)
                    }
                    
                    self.bestFollowerUserTableHeight.constant = CGFloat(90 * self.bestFollowerUsers.count)
                    self.bestFollowerUserTableView.reloadData()
                    self.bestFollowerUserView.isHidden = false
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }
    
    @objc func btnMainBestSongTapped(sender: UIButton) {
        let index = sender.tag
        let music = bestSongs[index]
        GlobalData.selectedMusics = [music]
        GlobalData.isRandom = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
    }
    
    @objc func btnMainBestPlaylistTapped(sender: UIButton) {
        let index = sender.tag
        GlobalData.selectedPlaylist = bestPlaylist[index]
        NotificationCenter.default.post(name: Notification.Name(rawValue: "goto_playlist"), object: nil)
    }

    @IBAction func onBestSongMore(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "show_back"), object: nil)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "BestSongsViewController") as! BestSongsViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onBestPlaylistMore(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "show_back"), object: nil)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "BestPlaylistViewController") as! BestPlaylistViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onBestLikedUsersMore(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "show_back"), object: nil)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "BestLikeUserViewController") as! BestLikeUserViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onBestFollowersMore(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "show_back"), object: nil)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "BestFollowersViewController") as! BestFollowersViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TopMusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension TopMusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1000 {
            return bestSongs.count
        } else if tableView.tag == 2000 {
            return bestPlaylist.count
        } else if tableView.tag == 3000 {
            return bestLikeUsers.count
        } else {
            return bestFollowerUsers.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 1000 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
            let music = bestSongs[indexPath.row]
            cell.imgThumbnail.kf.setImage(with: URL(string: music.thumbnail_url)!, placeholder: UIImage(named: "picture_placeholder"))
            cell.lblTitle.text = music.title
            cell.lblLikeCnt.text = "\(music.like_cnt)"
            cell.lblTime.text = CommonManager.shared.secToTime(sec: music.length)
            cell.lblPlayCnt.text = "\(music.play_cnt)"
            cell.lblUserName.text = "\(music.name)"
            cell.lblAddedCnt.text = "\(music.added_cnt)"
            
            cell.btnMain.tag = indexPath.row
            cell.btnMain.addTarget(self, action: #selector(btnMainBestSongTapped(sender:)), for: .touchUpInside)
            return cell
        } else if tableView.tag == 2000 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell", for: indexPath) as! PlaylistTableViewCell
            let p = bestPlaylist[indexPath.row]
            
            cell.lblTitle.text = p.title
            cell.lblTime.text = CommonManager.shared.secToTime(sec: p.length)
            cell.imgThumbnail.kf.setImage(with: URL(string: p.thumbnail_url)!, placeholder: UIImage(named: "picture_placeholder"))
            
            cell.btnMain.tag = indexPath.row
            cell.btnMain.addTarget(self, action: #selector(btnMainBestPlaylistTapped(sender:)), for: .touchUpInside)
            return cell
        } else if tableView.tag == 3000 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            let user = bestLikeUsers[indexPath.row]
            cell.lblName.text = user.name
            cell.lblLikeCnt.text = "\(user.like_cnt)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            let user = bestFollowerUsers[indexPath.row]
            cell.lblName.text = user.name
            cell.lblLikeCnt.text = "\(user.like_cnt)"
            return cell
        }
    }
}

extension TopMusicViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        dropDate.isSelected ?  dropDate.hideList() : dropDate.showList()
        return false
    }
}
