//
//  MusicListViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/11.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import AVKit

class MusicListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var musicList: [MusicModel] = []
    
    var selectedMusic = -1
    var isRandom = false
    var started = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewHeight.constant = CGFloat(90 * musicList.count)
    }

    func configureView() {
        
    }
    
    @IBAction func onRandom(_ sender: Any) {
        

        var temp: [MusicModel] = []
        for music in musicList {
            temp.append(music)
        }
        
        GlobalData.selectedMusics = temp.shuffled()
        GlobalData.isRandom = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
//        if musicList.count == 0 {
//            return
//        }
//
//        selectedMusic = Int.random(in: 0 ..< musicList.count)
//        isRandom = true
//        started = true
//        GlobalData.isPlayingBanner = false
//        playMusic(index: selectedMusic)
    }
    
    @IBAction func onPlayAll(_ sender: Any) {
        GlobalData.selectedMusics = musicList
        GlobalData.isRandom = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
//        if musicList.count == 0 {
//            return
//        }
//
//        selectedMusic = 0
//        isRandom = false
//        started = true
//        GlobalData.isPlayingBanner = false
//        playMusic(index: selectedMusic)
    }
    
    
//    func playMusic(index: Int) {
//        selectedMusic = index
//        let item = AVPlayerItem(url: URL(string: musicList[index].song_url)!)
//        GlobalData.isPlayingBanner = false
//        GlobalData.player = AVPlayer(playerItem: item)
//        GlobalData.player.play()
//
//        NotificationCenter.default.addObserver(self, selector:  #selector(playerDidFinishPlaying), name: .AVPlayerItemDidPlayToEndTime, object: item)
//    }
    
    @objc func btnMainTapped(sender: UIButton) {
        let index = sender.tag
        let music = musicList[index]
        GlobalData.selectedMusics = [music]
        GlobalData.isRandom = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
//
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

extension MusicListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension MusicListViewController: UITableViewDataSource {
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
