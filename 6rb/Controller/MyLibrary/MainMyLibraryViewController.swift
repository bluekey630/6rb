//
//  MainMyLibraryViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/26.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class MainMyLibraryViewController: UIViewController {

    @IBOutlet weak var imgDownloadTri: UIImageView!
    @IBOutlet weak var btnDownload: UIButton!
    
    @IBOutlet weak var imgLikedTri: UIImageView!
    @IBOutlet weak var btnLiked: UIButton!
    
    @IBOutlet weak var imgFollowerTri: UIImageView!
    @IBOutlet weak var btnFollower: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    

    func configureView() {
        imgDownloadTri.isHidden = false
        btnDownload.setTitleColor(UIColor.black, for: .normal)
        
        imgLikedTri.isHidden = true
        btnLiked.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgFollowerTri.isHidden = true
        btnFollower.setTitleColor(UIColor.lightGray, for: .normal)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "nav_library_login") as! UINavigationController
        addChild(vc)
        vc.view.frame = mainView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParent: self)
        mainView.addSubview(vc.view)
        
        GlobalData.from = "downloads"
    }

    @IBAction func onDownload(_ sender: Any) {
        imgDownloadTri.isHidden = false
        btnDownload.setTitleColor(UIColor.black, for: .normal)
        
        imgLikedTri.isHidden = true
        btnLiked.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgFollowerTri.isHidden = true
        btnFollower.setTitleColor(UIColor.lightGray, for: .normal)
        GlobalData.from = "downloads"
    }
    
    @IBAction func onLiked(_ sender: Any) {
        imgDownloadTri.isHidden = true
        btnDownload.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgLikedTri.isHidden = false
        btnLiked.setTitleColor(UIColor.black, for: .normal)
        
        imgFollowerTri.isHidden = true
        btnFollower.setTitleColor(UIColor.lightGray, for: .normal)
        GlobalData.from = "liked"
    }
    
    @IBAction func onFollowers(_ sender: Any) {
        imgDownloadTri.isHidden = true
        btnDownload.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgLikedTri.isHidden = true
        btnLiked.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgFollowerTri.isHidden = false
        btnFollower.setTitleColor(UIColor.black, for: .normal)
        GlobalData.from = "followers"
    }
}
