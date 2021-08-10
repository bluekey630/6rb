//
//  MainTabViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/21.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class MainTabViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var imgMusic: UIImageView!
    @IBOutlet weak var lblMusic: UILabel!
    
    @IBOutlet weak var imgChat: UIImageView!
    @IBOutlet weak var lblChat: UILabel!
    
    @IBOutlet weak var imgMain: UIImageView!
    
    @IBOutlet weak var imgSearch: UIImageView!
    @IBOutlet weak var lblSearch: UILabel!
    
    @IBOutlet weak var imgLibrary: UIImageView!
    @IBOutlet weak var lblLibrary: UILabel!
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lblSongName: UILabel!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var smallPlayerView: UIView!
    @IBOutlet weak var btnMinPlayerView: UIButton!
    
    
    var curVC: UIViewController?
    var curIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let data = UserDefaults.standard.dictionary(forKey: "user-data")
        if data != nil {
            GlobalData.myAccount = UserModel(dict: data!)
        }

        configureView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(openLibraryLogined), name:NSNotification.Name(rawValue: "open-library-logined"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openPlayerView), name:NSNotification.Name(rawValue: "open-playerview"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hidePlayerView), name:NSNotification.Name(rawValue: "hide-playerview"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updatePlayerView), name:NSNotification.Name(rawValue: "update-playerview"), object: nil)
        
    }
    

    func configureView() {
        imgMusic.image = UIImage(named: "ic_music_tab_on")
        lblMusic.textColor = UIColor(red: 0, green: 162/255, blue: 1, alpha: 1)
        
        imgChat.image = UIImage(named: "ic_chat_tab_off")
        lblChat.textColor = UIColor.black
        
        imgMain.image = UIImage(named: "ic_main_tab_off")
        
        imgSearch.image = UIImage(named: "ic_search_tab_off")
        lblSearch.textColor = UIColor.black
        
        imgLibrary.image = UIImage(named: "ic_library_tab_off")
        lblLibrary.textColor = UIColor.black
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_music") as! UINavigationController
        onShowVC(vc: vc, nextIndex: 0)
        
        let img = UIImage(color: UIColor(red: 61/255, green: 190/255, blue: 226/255, alpha: 1), size: CGSize(width: 6, height: 6))
        slider.setThumbImage(maskRoundedImage(image: img, radius: 6), for: .normal)
        slider.setThumbImage(maskRoundedImage(image: img, radius: 6), for: .highlighted)
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
    
    @IBAction func onMusic(_ sender: Any) {
        imgMusic.image = UIImage(named: "ic_music_tab_on")
        lblMusic.textColor = UIColor(red: 0, green: 162/255, blue: 1, alpha: 1)
        
        imgChat.image = UIImage(named: "ic_chat_tab_off")
        lblChat.textColor = UIColor.black
        
        imgMain.image = UIImage(named: "ic_main_tab_off")
        
        imgSearch.image = UIImage(named: "ic_search_tab_off")
        lblSearch.textColor = UIColor.black
        
        imgLibrary.image = UIImage(named: "ic_library_tab_off")
        lblLibrary.textColor = UIColor.black
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_music") as! UINavigationController
        onShowVC(vc: vc, nextIndex: 0)
    }
    
    @IBAction func onChat(_ sender: Any) {
        imgMusic.image = UIImage(named: "ic_music_tab_off")
        lblMusic.textColor = UIColor.black
        imgChat.image = UIImage(named: "ic_chat_tab_on")
        lblChat.textColor = UIColor(red: 0, green: 162/255, blue: 1, alpha: 1)
        
        imgMain.image = UIImage(named: "ic_main_tab_off")
        
        imgSearch.image = UIImage(named: "ic_search_tab_off")
        lblSearch.textColor = UIColor.black
        
        imgLibrary.image = UIImage(named: "ic_library_tab_off")
        lblLibrary.textColor = UIColor.black
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_chat") as! UINavigationController
        onShowVC(vc: vc, nextIndex: 1)
    }
    
    @IBAction func onMain(_ sender: Any) {
        imgMusic.image = UIImage(named: "ic_music_tab_off")
        lblMusic.textColor = UIColor.black
        imgChat.image = UIImage(named: "ic_chat_tab_off")
        lblChat.textColor = UIColor.black
        
        imgMain.image = UIImage(named: "ic_main_tab_on")
        
        imgSearch.image = UIImage(named: "ic_search_tab_off")
        lblSearch.textColor = UIColor.black
        
        imgLibrary.image = UIImage(named: "ic_library_tab_off")
        lblLibrary.textColor = UIColor.black
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_browse") as! UINavigationController
        onShowVC(vc: vc, nextIndex: 2)
    }
    
    @IBAction func onSearch(_ sender: Any) {
        imgMusic.image = UIImage(named: "ic_music_tab_off")
        lblMusic.textColor = UIColor.black
        imgChat.image = UIImage(named: "ic_chat_tab_off")
        lblChat.textColor = UIColor.black
        
        imgMain.image = UIImage(named: "ic_main_tab_off")
        
        imgSearch.image = UIImage(named: "ic_search_tab_on")
        lblSearch.textColor = UIColor(red: 0, green: 162/255, blue: 1, alpha: 1)
        
        imgLibrary.image = UIImage(named: "ic_library_tab_off")
        lblLibrary.textColor = UIColor.black
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_search") as! UINavigationController
        onShowVC(vc: vc, nextIndex: 3)
    }
    
    @IBAction func onMyLibrary(_ sender: Any) {
        imgMusic.image = UIImage(named: "ic_music_tab_off")
        lblMusic.textColor = UIColor.black
        imgChat.image = UIImage(named: "ic_chat_tab_off")
        lblChat.textColor = UIColor.black
        
        imgMain.image = UIImage(named: "ic_main_tab_off")
        
        imgSearch.image = UIImage(named: "ic_search_tab_off")
        lblSearch.textColor = UIColor.black
        
        imgLibrary.image = UIImage(named: "ic_library_tab_on")
        lblLibrary.textColor = UIColor(red: 0, green: 162/255, blue: 1, alpha: 1)
        if GlobalData.myAccount.id.count == 0 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "nav_library") as! UINavigationController
            onShowVC(vc: vc, nextIndex: 4)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "nav_library_logined") as! UINavigationController
            onShowVC(vc: vc, nextIndex: 5)
        }
        
    }
    
    @objc func openLibraryLogined() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_library_logined") as! UINavigationController
        onShowVC(vc: vc, nextIndex: 5)
    }
    
    func onShowVC(vc: UIViewController, nextIndex: Int) {
        if curIndex != nextIndex {
            ProgressHud.shared.dismiss()
            curIndex = nextIndex
            addChild(vc)
            
            if GlobalData.player != nil {
                GlobalData.player.pause()
            }
            
            vc.view.frame = mainView.bounds
            vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            vc.didMove(toParent: self)
            mainView.addSubview(vc.view)
            
            if curVC != nil {
                curVC?.view.removeFromSuperview()
            }
            curVC = vc
        }
    }
    
    @objc func openPlayerView() {
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "stop-all"), object: nil)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        addChild(vc)
        vc.view.frame = playerView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParent: self)
        playerView.addSubview(vc.view)
        
        UIView.animate(withDuration: 0.1, animations: {
            self.playerView.isHidden = false
            self.playerView.frame = self.mainView.frame
        }, completion: { _ in
            
            self.smallPlayerView.isHidden = true
            self.btnMinPlayerView.isHidden = true
        })
        
//        playerView.isHidden = false
//        btnMinPlayerView.isHidden = true
//        smallPlayerView.isHidden = true
        
    }
    
    @objc func hidePlayerView() {
        
        UIView.animate(withDuration: 0.1, animations: {
            self.playerView.frame = self.smallPlayerView.frame
        }, completion: { _ in
            self.playerView.isHidden = true
            self.smallPlayerView.isHidden = false
            self.btnMinPlayerView.isHidden = true
        })
    }
    
    @IBAction func hideSmallPlayerView(_ sender: Any) {
        playerView.isHidden = true
        smallPlayerView.isHidden = true
        btnMinPlayerView.isHidden = false
    }
    
    @IBAction func showSmallPlayerView(_ sender: Any) {
        playerView.isHidden = true
        smallPlayerView.isHidden = false
        btnMinPlayerView.isHidden = true
    }
    
    @IBAction func showFullPlayerView(_ sender: Any) {
        UIView.animate(withDuration: 0.1, animations: {
            self.playerView.isHidden = false
            self.playerView.frame = self.mainView.frame
        }, completion: { _ in
            
            self.smallPlayerView.isHidden = true
            self.btnMinPlayerView.isHidden = true
        })
        
    }
    
    @objc func updatePlayerView() {
        if GlobalData.selectedMusic.id.count > 0 {
            lblSongName.text = GlobalData.selectedMusic.title
            let url = URL(string: GlobalData.selectedMusic.avatar)
            if url != nil {
                imgAvatar.kf.setImage(with: url, placeholder: UIImage(named: "picture_placeholder"))
            } else {
                imgAvatar.image = UIImage(named: "picture_placeholder")
            }
            
            if GlobalData.playerState == .paused {
                btnPlay.setImage(UIImage(named: "ic_transparent_play"), for: .normal)
            } else {
                btnPlay.setImage(UIImage(named: "ic_pause"), for: .normal)
            }
            
            slider.value = GlobalData.sliderValue
        }
    }
    
    @IBAction func onPlayPause(_ sender: Any) {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "update-playerstate"), object: nil)
    }
    
    @IBAction func changedSliderValue(_ sender: Any) {
        GlobalData.sliderValue = slider.value
        NotificationCenter.default.post(name: Notification.Name(rawValue: "update-sliderstate"), object: nil)
    }
    
}
