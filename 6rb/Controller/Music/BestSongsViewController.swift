//
//  BestSongsViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/17.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import AVKit

class BestSongsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var dropDate: DropDown!
    
    var musicList: [MusicModel] = []
    var date: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        date = "week"
        getBestSongs()
    }
    
    func configureView() {
        dropDate.optionArray = ["WEEK", "MONTH", "YEAR"]
        dropDate.selectValue(index: 0)
        dropDate.didSelect(completion: {selectedText, index, id in
            print(selectedText, index, id)
            self.date = selectedText.lowercased()
            self.getBestSongs()
        })
        
        dropDate.delegate = self
        
        tableView.isHidden = true
    }
    
    func getBestSongs() {
        musicList = []
        APIManager.shared.getBestSongs(more: true, date: date, completion: {
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
                        self.musicList.append(music)
                    }
                    
                    self.tableViewHeight.constant = CGFloat(90 * self.musicList.count)
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
        let index = sender.tag
        let music = musicList[index]
        GlobalData.selectedMusics = [music]
        GlobalData.isRandom = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
    }

//    func playMusic(index: Int) {
//        GlobalData.isPlayingBanner = false
//        let item = AVPlayerItem(url: URL(string: musicList[index].song_url)!)
//
//        GlobalData.player = AVPlayer(playerItem: item)
//        GlobalData.player.play()
//
//    }
}

extension BestSongsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension BestSongsViewController: UITableViewDataSource {
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
        
        cell.btnMain.tag = indexPath.row
        cell.btnMain.addTarget(self, action: #selector(btnMainTapped(sender:)), for: .touchUpInside)
        return cell
    }
}

extension BestSongsViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        dropDate.isSelected ?  dropDate.hideList() : dropDate.showList()
        return false
    }
}
