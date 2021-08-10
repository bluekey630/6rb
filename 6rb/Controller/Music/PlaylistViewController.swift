//
//  PlaylistViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/22.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import AVKit

class PlaylistViewController: UIViewController {

    @IBOutlet weak var lblPlaylistTitle: UILabel!
    @IBOutlet weak var lblLikeCount: UILabel!
    @IBOutlet weak var lblSongCount: UILabel!
    @IBOutlet weak var lblPlayCount: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgAvatar: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var musicList: [MusicModel] = []
    var selectedMusic = -1
    var isRandom = false
    var started = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getDetailPlaylistSongs()
    }
    

    func configureView() {
        let playlist = GlobalData.selectedPlaylist
        lblPlaylistTitle.text = playlist.title
        lblLikeCount.text = "\(playlist.like_cnt)"
        lblPlayCount.text = "Total Play \(playlist.play_cnt)"
        lblSongCount.text = "0"
        imgAvatar.kf.setImage(with: URL(string: playlist.avatar)!, placeholder: UIImage(named: "picture_placeholder"))
        lblUserName.text = playlist.name
    }
    
    func getDetailPlaylistSongs() {
        let id = GlobalData.selectedPlaylist.id
        if id.count == 0 {
            return
        }
        
        ProgressHud.shared.show(view: view, msg: "")
        musicList = []
        APIManager.shared.getDetailPlayListSongs(id: id, completion: {
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
                    self.lblSongCount.text = "\(self.musicList.count)"
                    self.tableView.reloadData()
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }

    @IBAction func onBack(_ sender: Any) {
    
        if GlobalData.player != nil {
            GlobalData.player.pause()
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onRandomPlay(_ sender: Any) {
        if musicList.count == 0 {
            return
        }
        var temp: [MusicModel] = []
        for music in musicList {
            temp.append(music)
        }
        
        GlobalData.selectedMusics = temp.shuffled()
        GlobalData.isRandom = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
//        selectedMusic = Int.random(in: 0 ..< musicList.count)
//        isRandom = true
//        started = true
//        GlobalData.isPlayingBanner = false
//        playMusic(index: selectedMusic)
    }
    
    @IBAction func onPlayAll(_ sender: Any) {
        if musicList.count == 0 {
            return
        }
        GlobalData.selectedMusics = musicList
        GlobalData.isRandom = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
//        selectedMusic = 0
//        isRandom = false
//        started = true
//        GlobalData.isPlayingBanner = false
//        playMusic(index: selectedMusic)
    }
    
    @objc func btnMainTapped(sender: UIButton) {
        let index = sender.tag
        let music = musicList[index]
        GlobalData.selectedMusics = [music]
        GlobalData.isRandom = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
//        let item = AVPlayerItem(url: URL(string: music.song_url)!)
//
//        if GlobalData.player != nil {
//            GlobalData.player.pause()
//        }
//
//        GlobalData.isPlayingBanner = false
//
//        GlobalData.player = AVQueuePlayer(items: [item])
//        GlobalData.player.play()
    }
    
//    func playMusic(index: Int) {
//        selectedMusic = index
//        let item = AVPlayerItem(url: URL(string: musicList[index].song_url)!)
//
//        GlobalData.player = AVPlayer(playerItem: item)
//        GlobalData.player.play()
//
//        NotificationCenter.default.addObserver(self, selector:  #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: item)
//        tableView.reloadData()
//    }
//
//    @objc func playerDidFinishPlaying(note: NSNotification) {
//        if !started {
//            return
//        }
//
//        if !isRandom {
//            selectedMusic += 1
//            if selectedMusic == musicList.count {
//                selectedMusic = -1
//            } else {
//                playMusic(index: selectedMusic)
//            }
//        } else {
//            selectedMusic = Int.random(in: 0 ..< musicList.count)
//            playMusic(index: selectedMusic)
//        }
//    }
}

extension PlaylistViewController: UITableViewDataSource {
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
        
//        if selectedMusic == indexPath.row {
//            cell.contentView.backgroundColor = UIColor.yellow
//        } else {
//            cell.contentView.backgroundColor = UIColor.white
//        }
        
        return cell
    }
    
    
}

extension PlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
}
