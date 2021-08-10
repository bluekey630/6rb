//
//  LoginedMyLibViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/26.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class LoginedMyLibViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var imgDownloadTri: UIImageView!
    @IBOutlet weak var btnDownload: UIButton!
    
    @IBOutlet weak var imgLikedTri: UIImageView!
    @IBOutlet weak var btnLiked: UIButton!
    
    @IBOutlet weak var imgFollowerTri: UIImageView!
    @IBOutlet weak var btnFollower: UIButton!
    
    var curVC: UIViewController?
    var curIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    

    func configureView() {
        if GlobalData.from == "liked" {
            imgDownloadTri.isHidden = true
            btnDownload.setTitleColor(UIColor.lightGray, for: .normal)
            
            imgLikedTri.isHidden = false
            btnLiked.setTitleColor(UIColor.black, for: .normal)
            
            imgFollowerTri.isHidden = true
            btnFollower.setTitleColor(UIColor.lightGray, for: .normal)
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "LikedLibViewController") as! LikedLibViewController
            onShowVC(vc: vc, nextIndex: 1)
        } else if GlobalData.from == "followers" {
            imgDownloadTri.isHidden = true
            btnDownload.setTitleColor(UIColor.lightGray, for: .normal)
            
            imgLikedTri.isHidden = true
            btnLiked.setTitleColor(UIColor.lightGray, for: .normal)
            
            imgFollowerTri.isHidden = false
            btnFollower.setTitleColor(UIColor.black, for: .normal)
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "FollowersLibViewController") as! FollowersLibViewController
            onShowVC(vc: vc, nextIndex: 2)
        } else {
            imgDownloadTri.isHidden = false
            btnDownload.setTitleColor(UIColor.black, for: .normal)
            
            imgLikedTri.isHidden = true
            btnLiked.setTitleColor(UIColor.lightGray, for: .normal)
            
            imgFollowerTri.isHidden = true
            btnFollower.setTitleColor(UIColor.lightGray, for: .normal)
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "DownloadLibViewController") as! DownloadLibViewController
            onShowVC(vc: vc, nextIndex: 0)
        }
    }
    
    @IBAction func onDownload(_ sender: Any) {
        imgDownloadTri.isHidden = false
        btnDownload.setTitleColor(UIColor.black, for: .normal)
        
        imgLikedTri.isHidden = true
        btnLiked.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgFollowerTri.isHidden = true
        btnFollower.setTitleColor(UIColor.lightGray, for: .normal)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DownloadLibViewController") as! DownloadLibViewController
        onShowVC(vc: vc, nextIndex: 0)
        
    }
    
    @IBAction func onLiked(_ sender: Any) {
        imgDownloadTri.isHidden = true
        btnDownload.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgLikedTri.isHidden = false
        btnLiked.setTitleColor(UIColor.black, for: .normal)
        
        imgFollowerTri.isHidden = true
        btnFollower.setTitleColor(UIColor.lightGray, for: .normal)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "LikedLibViewController") as! LikedLibViewController
        onShowVC(vc: vc, nextIndex: 1)
        
    }
    
    @IBAction func onFollowers(_ sender: Any) {
        imgDownloadTri.isHidden = true
        btnDownload.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgLikedTri.isHidden = true
        btnLiked.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgFollowerTri.isHidden = false
        btnFollower.setTitleColor(UIColor.black, for: .normal)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "FollowersLibViewController") as! FollowersLibViewController
        onShowVC(vc: vc, nextIndex: 2)
        
    }
    
    @IBAction func onSetting(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SettingAccountViewController") as! SettingAccountViewController
        present(vc, animated: true, completion: nil)
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
        }
    }

}
