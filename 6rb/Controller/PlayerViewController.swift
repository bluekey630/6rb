//
//  PlayerViewController.swift
//  6rb
//
//  Created by Admin on 10/21/19.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import SwiftAudio

class PlayerViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var lblStartTime: UILabel!
    @IBOutlet weak var lblEndTime: UILabel!
    
    @IBOutlet weak var btnRandom: UIButton!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnRepeat: UIButton!
    
    
    var musicList: [MusicModel] = []
    var curIndex = 0
    var nextIndex = -1
    
    var player = QueuedAudioPlayer()
    var isLoading = false
    var timer: Timer!
    
    var isRepeat = true
    var isRandom = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        musicList = GlobalData.selectedMusics
        isRandom = GlobalData.isRandom
        configureView()
        
        initData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayerState), name:NSNotification.Name(rawValue: "update-playerstate"), object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(updateSliderState), name:NSNotification.Name(rawValue: "update-sliderstate"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(stopAll), name:NSNotification.Name(rawValue: "stop-all"), object: nil)
    }
    

    func configureView() {
        let img = UIImage(color: UIColor(red: 61/255, green: 190/255, blue: 226/255, alpha: 1), size: CGSize(width: 6, height: 6))
        slider.setThumbImage(maskRoundedImage(image: img, radius: 6), for: .normal)
        slider.setThumbImage(maskRoundedImage(image: img, radius: 6), for: .highlighted)
        
        isRandom ? btnRandom.setImage(UIImage(named: "ic_random_yello"), for: .normal) : btnRandom.setImage(UIImage(named: "ic_random_white"), for: .normal)
    }
    
    func initData() {
        player = QueuedAudioPlayer()
        player.event.stateChange.addListener(self, changedAudioPlayerStateChanged)
        player.event.playbackEnd.addListener(self, endedPlayMusic)
        for music in musicList {
            let audioItem = DefaultAudioItem(audioUrl: music.song_url, sourceType: .stream)
            try! player.add(item: audioItem, playWhenReady: true)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func stopAll() {
        timer.invalidate()
        player.stop()
    }
    
    func maskRoundedImage(image: UIImage, radius: CGFloat) -> UIImage {
        let imageView = UIImageView(image: image)
        let layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = radius
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundImage!
    }

    @IBAction func onHide(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "hide-playerview"), object: nil)
    }
    
    @IBAction func onFastForward(_ sender: Any) {
        var val = player.currentTime + 5
        if val >= player.duration {
            val = player.duration
        }
        player.seek(to: val)
    }
    
    @IBAction func onFastBackward(_ sender: Any) {
        var val = player.currentTime - 5
        if val <= 0 {
            val = 0
        }
        player.seek(to: val)
    }
    
    @IBAction func onRepeat(_ sender: Any) {
        isRepeat = !isRepeat
        isRepeat ? btnRepeat.setImage(UIImage(named: "ic_repeat"), for: .normal) : btnRepeat.setImage(UIImage(named: "ic_norepeat"), for: .normal)
    }
    
    @IBAction func onPlayPause(_ sender: Any) {
        player.togglePlaying()
        if player.playerState == .paused {
            btnPlay.setImage(UIImage(named: "ic_transparent_play"), for: .normal)
        } else {
            btnPlay.setImage(UIImage(named: "ic_pause"), for: .normal)
        }
    }
    
    @objc func updatePlayerState() {
        player.togglePlaying()
        if player.playerState == .paused {
            btnPlay.setImage(UIImage(named: "ic_transparent_play"), for: .normal)
        } else {
            btnPlay.setImage(UIImage(named: "ic_pause"), for: .normal)
        }
    }
    
    @objc func updateSliderState() {
        slider.setValue(GlobalData.sliderValue, animated: true)
        let curTime = Double(slider.value) * player.duration
        player.seek(to: curTime)
    }
    
    @IBAction func changedSliderValue(_ sender: Any) {
        let curTime = Double(slider.value) * player.duration
        player.seek(to: curTime)
    }
    
    func changedAudioPlayerStateChanged(state: AudioPlayerState) {
        print(state)
        if state == .loading {
            let index = player.currentIndex
            isLoading = true
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at:IndexPath(item: index, section: 0), at: .right, animated: true)
            }
            
            if GlobalData.myAccount.id.count > 0 {
                let id = musicList[index].id
                let body = [
                    "id_song": id
                ]
                APIManager.shared.playSong(body: body, completion: {
                    error, response in
                    print(response)
                })
            }
        }
    }
    
    func endedPlayMusic(data: AudioPlayer.PlaybackEndEventData) {
        if data == .playedUntilEnd && isRepeat && player.currentIndex == musicList.count - 1 {
            initData()
            curIndex = 0
            nextIndex = -1
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at:IndexPath(item: 0, section: 0), at: .right, animated: true)
            }
            
        } else if data == .playedUntilEnd && !isRepeat && player.currentIndex == musicList.count - 1 {
            btnPlay.setImage(UIImage(named: "ic_transparent_play"), for: .normal)
        }
    }
    
    @objc func updateTimer() {
        lblStartTime.text = CommonManager.shared.secToTime(sec: Int(player.currentTime))
        lblEndTime.text = CommonManager.shared.secToTime(sec: Int(player.duration))
        let rate = player.currentTime / player.duration
        slider.setValue(Float(rate), animated: true)
        GlobalData.selectedMusic = musicList[player.currentIndex]
        GlobalData.playerState = player.playerState
        GlobalData.sliderValue = slider.value
        NotificationCenter.default.post(name: Notification.Name(rawValue: "update-playerview"), object: nil)
    }
}

extension PlayerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        var index = -1
        
        if indexPath.item == curIndex {
            index = nextIndex
        }
        
        if index != curIndex && index != -1 {
            curIndex = index
            print(curIndex)
            if curIndex != player.currentIndex {
                try! player.jumpToItem(atIndex: curIndex, playWhenReady: true)
                btnPlay.setImage(UIImage(named: "ic_pause"), for: .normal)
            }
        }
        isLoading = false
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        nextIndex = indexPath.item
    }
}

extension PlayerViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCollectionViewCell", for: indexPath) as! MusicCollectionViewCell
        let music = musicList[indexPath.item]
        cell.imgAvatar.layer.borderColor = UIColor.white.cgColor
        cell.imgAvatar.kf.setImage(with: URL(string: music.avatar)!, placeholder: UIImage(named: "picture_placeholder"))
        cell.lblUserName.text = music.name
        cell.lblSongTitle.text = music.title
        return cell
    }
}

extension PlayerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width//UIScreen.main.bounds.size.width
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)

    }
}
