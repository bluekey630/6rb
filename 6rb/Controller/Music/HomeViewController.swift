//
//  HomeViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/11.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher
import AVKit

class HomeViewController: UIViewController {

    @IBOutlet weak var lblMusic: UILabel!
    @IBOutlet weak var imgMusicTri: UIImageView!
    
    @IBOutlet weak var lblTop: UILabel!
    @IBOutlet weak var imgTopTri: UIImageView!
    
    
    @IBOutlet weak var lblTalent: UILabel!
    @IBOutlet weak var imgTalentTri: UIImageView!
    
    @IBOutlet weak var lblPlaylist: UILabel!
    @IBOutlet weak var imgPlaylistTri: UIImageView!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var topTitleView: UIView!
    
    @IBOutlet weak var galeryView: FSPagerView! {
        didSet {
            self.galeryView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    @IBOutlet weak var mainView: UIView!
    
    var curVC: UIViewController?
    var curIndex = -1
    
    var bannerMusics: [MusicModel] = []
    var selectedBannerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showBack), name:NSNotification.Name(rawValue: "show_back"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(gotoPlaylist), name:NSNotification.Name(rawValue: "goto_playlist"), object: nil)
        
        getBannerMusicList()
    }
    
    
    func configureView() {
        lblMusic.textColor = UIColor.black
        imgMusicTri.isHidden = false
        
        lblTop.textColor = UIColor.lightGray
        imgTopTri.isHidden = true
        
        lblTalent.textColor = UIColor.lightGray
        imgTalentTri.isHidden = true
        
        lblPlaylist.textColor = UIColor.lightGray
        imgPlaylistTri.isHidden = true
        
        btnBack.isHidden = true
        
        galeryView.transformer = FSPagerViewTransformer(type: .overlap)
        galeryView.itemSize = CGSize(width: 140, height: 135)
        galeryView.isInfinite = true
        galeryView.delegate = self
        galeryView.dataSource = self
        
        topTitleView.isHidden = true
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_music_home")
        onShowVC(vc: vc!, nextIndex: 0)
        
    }
    
    func getBannerMusicList() {
        if GlobalData.bannerMusics.count > 0 {
            bannerMusics = GlobalData.bannerMusics
            if self.bannerMusics.count > 0 {
                self.lblTitle.text = self.bannerMusics[0].title
            }
            self.galeryView.reloadData()
        } else {
            ProgressHud.shared.show(view: view, msg: "")
            bannerMusics = []
            APIManager.shared.getBannerMusicList(completion: {
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
                            self.bannerMusics.append(music)
                        }
                        if self.bannerMusics.count > 0 {
                            self.lblTitle.text = self.bannerMusics[0].title
                        }
                        self.galeryView.reloadData()
                        GlobalData.bannerMusics = self.bannerMusics
                    } else {
                        let message = res["message"] as! String
                        CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                    }
                }
            })
        }
        
    }
    
    @IBAction func onMusic(_ sender: Any) {
        lblMusic.textColor = UIColor.black
        imgMusicTri.isHidden = false
        
        lblTop.textColor = UIColor.lightGray
        imgTopTri.isHidden = true
        
        lblTalent.textColor = UIColor.lightGray
        imgTalentTri.isHidden = true
        
        lblPlaylist.textColor = UIColor.lightGray
        imgPlaylistTri.isHidden = true
        
//        btnBack.isHidden = true
        
//        lblTitle.text = "Welcome to Dj Boom"
        let music = bannerMusics[selectedBannerIndex]
        lblTitle.text = music.title
        lblTitle.isHidden = false
        
        topTitleView.isHidden = true
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_music_home")
        onShowVC(vc: vc!, nextIndex: 0)
    }
    
    @IBAction func onTop(_ sender: Any) {
        lblMusic.textColor = UIColor.lightGray
        imgMusicTri.isHidden = true
        
        lblTop.textColor = UIColor.black
        imgTopTri.isHidden = false
        
        lblTalent.textColor = UIColor.lightGray
        imgTalentTri.isHidden = true
        
        lblPlaylist.textColor = UIColor.lightGray
        imgPlaylistTri.isHidden = true
        
        btnBack.isHidden = true
        
        lblTitle.isHidden = true
        topTitleView.isHidden = false
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_6rb_home")
        onShowVC(vc: vc!, nextIndex: 1)
    }
    
    @IBAction func onTalents(_ sender: Any) {
        lblMusic.textColor = UIColor.lightGray
        imgMusicTri.isHidden = true
        
        lblTop.textColor = UIColor.lightGray
        imgTopTri.isHidden = true
        
        lblTalent.textColor = UIColor.black
        imgTalentTri.isHidden = false
        
        lblPlaylist.textColor = UIColor.lightGray
        imgPlaylistTri.isHidden = true
        
        btnBack.isHidden = true
        
        lblTitle.text = "Talents"
        lblTitle.isHidden = false
        topTitleView.isHidden = true
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_talent_home")
        onShowVC(vc: vc!, nextIndex: 2)
    }
    
    
    @IBAction func onPlaylist(_ sender: Any) {
        lblMusic.textColor = UIColor.lightGray
        imgMusicTri.isHidden = true
        
        lblTop.textColor = UIColor.lightGray
        imgTopTri.isHidden = true
        
        lblTalent.textColor = UIColor.lightGray
        imgTalentTri.isHidden = true
        
        lblPlaylist.textColor = UIColor.black
        imgPlaylistTri.isHidden = false
        
        btnBack.isHidden = true
        
        lblTitle.text = "User Playlist"
        lblTitle.isHidden = false
        topTitleView.isHidden = true
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_playlist_home")
        onShowVC(vc: vc!, nextIndex: 3)
    }
    
    @IBAction func onBack(_ sender: Any) {
        if GlobalData.player != nil && !GlobalData.isPlayingBanner {
            GlobalData.player.pause()
        }
        
        let cnt = curVC?.navigationController?.viewControllers.count ?? 0
        btnBack.isHidden = cnt > 1 ? false : true
        if curVC is RandomMusicViewController {
            print(true)
        }
        let vc = curVC as! UINavigationController
        vc.popViewController(animated: true)
//        NotificationCenter.default.post(name: Notification.Name(rawValue: "logout"), object: nil)
//        let animation = CATransition()
//        animation.type = CATransitionType.reveal
//        animation.duration = 0.2
//        animation.subtype = CATransitionSubtype.fromLeft
//        musicListConView.layer.add(animation, forKey: nil)
//        musicListConView.isHidden = true
        
//        btnBack.isHidden = true
    }
    
    @objc func showBack() {

        btnBack.isHidden = false
        
    }
    
    func onShowVC(vc: UIViewController, nextIndex: Int) {
        if curIndex != nextIndex {
            if GlobalData.player != nil && !GlobalData.isPlayingBanner{
                GlobalData.player.pause()
            }
            curIndex = nextIndex
            addChild(vc)
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
    
    @objc func gotoPlaylist() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlaylistViewController") as! PlaylistViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func onBannerPlay(_ sender: Any) {
        let music = bannerMusics[selectedBannerIndex]
        GlobalData.selectedMusics = [music]
        GlobalData.isRandom = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
//        var items: [AVPlayerItem] = []
        
//        let item = AVPlayerItem(url: URL(string: music.song_url)!)
////        items.append(item)
//        GlobalData.isPlayingBanner = true
//        GlobalData.player = AVPlayer(playerItem: item)
//        GlobalData.player.play()
    }
    
}

extension HomeViewController: FSPagerViewDelegate {
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
//        print(index)
    }
    
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int) {
//        print(index)
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didHighlightItemAt index: Int) {
        //print(index)
        
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        selectedBannerIndex = targetIndex
        let music = bannerMusics[targetIndex]
        lblTitle.text = music.title
    }
}

extension HomeViewController: FSPagerViewDataSource {
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return bannerMusics.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        
        let music = bannerMusics[index]
        cell.imageView!.kf.setImage(with: URL(string: music.thumbnail_url)!, placeholder: UIImage(named: "picture_placeholder"))
//        cell.imageView?.image = //UIImage(named: "picture_placeholder")
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.borderColor = UIColor.white.cgColor
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.masksToBounds = true
        cell.imageView?.layer.cornerRadius = 10
        
        return cell
    }
}

