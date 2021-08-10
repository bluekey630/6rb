//
//  BrowseHistoryViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/26.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class BrowseHistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var musicList: [MusicModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getHistoryMusics()
    }
    
    func configureView() {
        
    }
    
    func getHistoryMusics() {
        ProgressHud.shared.show(view: view, msg: "")
        APIManager.shared.getHistorySongs(completion: {
            error, response in
            ProgressHud.shared.dismiss()
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
                        self.musicList.append(music)
                    }
                    
                    self.tableView.reloadData()
                    
                    self.tableViewHeight.constant = CGFloat(100 * self.musicList.count)
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }
    
    @IBAction func onRandom(_ sender: Any) {
        var temp: [MusicModel] = []
        for music in musicList {
            temp.append(music)
        }
        
        GlobalData.selectedMusics = temp.shuffled()
        GlobalData.isRandom = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
    }
    
    @IBAction func onPlayAll(_ sender: Any) {
        GlobalData.selectedMusics = musicList
        GlobalData.isRandom = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
    }
    
    @objc func btnMainTapped(sender: UIButton) {
        let index = sender.tag
        let music = musicList[index]
        GlobalData.selectedMusics = [music]
        GlobalData.isRandom = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
    }
}

extension BrowseHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
        let music = musicList[indexPath.row]
        cell.imgThumbnail.kf.setImage(with: URL(string: music.thumbnail_url)!, placeholder: UIImage(named: "picture_placeholder"))
        cell.lblTitle.text = music.title
        cell.lblLikeCnt.text = "\(music.like_cnt)"
        cell.lblTime.text = CommonManager.shared.secToTime(sec: music.length)
        cell.lblPlayCnt.text = "\(music.play_cnt)"
        cell.lblUserName.text = "\(music.name)"
        cell.lblAddedCnt.text = "\(music.added_cnt)"
        cell.btnMain.tag = indexPath.row
        cell.btnMain.addTarget(self, action: #selector(btnMainTapped(sender:)), for: .touchUpInside)
        return cell
    }
}

extension BrowseHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
}
