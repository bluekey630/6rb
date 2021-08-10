//
//  MainBrowseViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/26.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import FSPagerView

class MainBrowseViewController: UIViewController {
    @IBOutlet weak var lblHistory: UILabel!
    @IBOutlet weak var imgHistoryTri: UIImageView!
    
    @IBOutlet weak var lblPlaylist: UILabel!
    @IBOutlet weak var imgPlaylistTri: UIImageView!
    
    @IBOutlet weak var lblMySong: UILabel!
    @IBOutlet weak var imgMysongTri: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    
    var curVC: UIViewController?
    var curIndex = -1
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var galeryView: FSPagerView! {
        didSet {
            self.galeryView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    var bannerMusics: [MusicModel] = []
    var selectedBannerIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        getBannerMusicList()
        
        NotificationCenter.default.addObserver(self, selector: #selector(gotoPlaylist), name:NSNotification.Name(rawValue: "goto_playlist_browse"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(showBack), name:NSNotification.Name(rawValue: "show-browse-back"), object: nil)
    }
    
    func configureView() {
        lblHistory.textColor = UIColor.black
        imgHistoryTri.isHidden = false
        
        lblPlaylist.textColor = UIColor.lightGray
        imgPlaylistTri.isHidden = true
        
        lblMySong.textColor = UIColor.lightGray
        imgMysongTri.isHidden = true
        
        
        galeryView.transformer = FSPagerViewTransformer(type: .overlap)
        galeryView.itemSize = CGSize(width: 140, height: 135)
        galeryView.delegate = self
        galeryView.dataSource = self
        galeryView.isInfinite = true
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_login") as! UINavigationController
        GlobalData.from = "history"
        onShowVC(vc: vc, nextIndex: 0)
    }
    
    func getBannerMusicList() {
        if GlobalData.bannerMusics.count > 0 {
            bannerMusics = GlobalData.bannerMusics
//            if self.bannerMusics.count > 0 {
//                self.lblTitle.text = self.bannerMusics[0].title
//            }
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
//                        if self.bannerMusics.count > 0 {
//                            self.lblTitle.text = self.bannerMusics[0].title
//                        }
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
    
    @IBAction func onPlayBanner(_ sender: Any) {
        let music = bannerMusics[selectedBannerIndex]
        GlobalData.selectedMusics = [music]
        GlobalData.isRandom = false
        NotificationCenter.default.post(name: Notification.Name(rawValue: "open-playerview"), object: nil)
    }
    
    @IBAction func onHistory(_ sender: Any) {
        lblHistory.textColor = UIColor.black
        imgHistoryTri.isHidden = false
        
        lblPlaylist.textColor = UIColor.lightGray
        imgPlaylistTri.isHidden = true
        
        lblMySong.textColor = UIColor.lightGray
        imgMysongTri.isHidden = true
    
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_login") as! UINavigationController
        GlobalData.from = "history"
        onShowVC(vc: vc, nextIndex: 0)
    }
    
    @IBAction func onPlaylist(_ sender: Any) {
        lblHistory.textColor = UIColor.lightGray
        imgHistoryTri.isHidden = true
        
        lblPlaylist.textColor = UIColor.black
        imgPlaylistTri.isHidden = false
        
        lblMySong.textColor = UIColor.lightGray
        imgMysongTri.isHidden = true
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_login") as! UINavigationController
        GlobalData.from = "myplaylist"
        onShowVC(vc: vc, nextIndex: 1)
    }
    
    @IBAction func onMySong(_ sender: Any) {
        lblHistory.textColor = UIColor.lightGray
        imgHistoryTri.isHidden = true
        
        lblPlaylist.textColor = UIColor.lightGray
        imgPlaylistTri.isHidden = true
        
        lblMySong.textColor = UIColor.black
        imgMysongTri.isHidden = false
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_login") as! UINavigationController
        GlobalData.from = "mysongs"
        onShowVC(vc: vc, nextIndex: 2)
    }
    
    func onShowVC(vc: UIViewController, nextIndex: Int) {
        if curIndex != nextIndex {
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
            btnBack.isHidden = true
        }
    }
    
    @objc func gotoPlaylist() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlaylistViewController") as! PlaylistViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onBack(_ sender: Any) {
        let nav = curVC as! UINavigationController
        nav.popViewController(animated: true)
        btnBack.isHidden = true
    }
    
    @objc func showBack() {
        btnBack.isHidden = false
    }
}


extension MainBrowseViewController: FSPagerViewDelegate {
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        selectedBannerIndex = targetIndex
//        let music = bannerMusics[targetIndex]
//        lblTitle.text = music.title
    }
}

extension MainBrowseViewController: FSPagerViewDataSource {
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

