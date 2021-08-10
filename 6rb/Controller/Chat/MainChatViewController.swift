//
//  MainChatViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/26.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class MainChatViewController: UIViewController {

    @IBOutlet weak var img6rbTri: UIImageView!
    @IBOutlet weak var btn6rb: UIButton!
    
    @IBOutlet weak var imgFriendTri: UIImageView!
    @IBOutlet weak var btnFriend: UIButton!
    
    @IBOutlet weak var imgProTri: UIImageView!
    
    @IBOutlet weak var mainView: UIView!
    
    
    var curVC: UIViewController?
    var curIndex = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
    }
    

    func configureView() {
        img6rbTri.isHidden = false
        btn6rb.setTitleColor(UIColor.black, for: .normal)
        
        imgFriendTri.isHidden = true
        btnFriend.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgProTri.isHidden = true
        
//        if GlobalData.isLogin {
//            let vc = storyboard?.instantiateViewController(withIdentifier: "nav_6rb_chat") as! UINavigationController
//            onShowVC(vc: vc, nextIndex: 0)
//        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "nav_login") as! UINavigationController
            GlobalData.from = "6rb"
            onShowVC(vc: vc, nextIndex: 0)
//        }
    }

    @IBAction func on6rb(_ sender: Any) {
        img6rbTri.isHidden = false
        btn6rb.setTitleColor(UIColor.black, for: .normal)
        
        imgFriendTri.isHidden = true
        btnFriend.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgProTri.isHidden = true
        
//        if GlobalData.isLogin {
//
//        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "nav_login") as! UINavigationController
            GlobalData.from = "6rb"
            onShowVC(vc: vc, nextIndex: 0)
//        }
    }
    
    @IBAction func onFriends(_ sender: Any) {
        img6rbTri.isHidden = true
        btn6rb.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgFriendTri.isHidden = false
        btnFriend.setTitleColor(UIColor.black, for: .normal)
        
        imgProTri.isHidden = true
        
//        if GlobalData.isLogin {
//
//        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "nav_login") as! UINavigationController
            GlobalData.from = "friend"
            onShowVC(vc: vc, nextIndex: 1)
//        }
    }
    
    @IBAction func onPro(_ sender: Any) {
        img6rbTri.isHidden = true
        btn6rb.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgFriendTri.isHidden = true
        btnFriend.setTitleColor(UIColor.lightGray, for: .normal)
        
        imgProTri.isHidden = false
        
//        if GlobalData.isLogin {
//
//        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "nav_login") as! UINavigationController
            GlobalData.from = "pro"
            onShowVC(vc: vc, nextIndex: 2)
//        }
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
