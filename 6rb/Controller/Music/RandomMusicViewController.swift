//
//  RandomMusicViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/9/11.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit

class RandomMusicViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var musicArryList: [Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getRandomMusicList()
    }
    

    func configureView() {
        
    }
    
    func getRandomMusicList() {
        APIManager.shared.getRandomMusicList(completion: {
            error, response in
            
            if error != nil {
                CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: error!.localizedDescription)
            } else {
                let res = response as! [String: Any]
                let code = res["status"] as! Int
                if code == 200 {
                    self.musicArryList = res["data"] as! [Any]
                    
                    self.collectionView.reloadData()
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }

}

extension RandomMusicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicArryList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomMusicCollectionViewCell", for: indexPath) as! RandomMusicCollectionViewCell
        cell.conView.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    
}

extension RandomMusicViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let animation = CATransition()
//        animation.type = CATransitionType.moveIn
//        animation.duration = 0.2
//        animation.subtype = CATransitionSubtype.fromRight
//        musicListConView.layer.add(animation, forKey: nil)
//        musicListConView.isHidden = false
//
//        btnBack.isHidden = false
        let list = musicArryList[indexPath.item] as! [Any]
        var musicList: [MusicModel] = []
        
        for l in list {
            let music = MusicModel(dict: l as! [String: Any])
            musicList.append(music)
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "show_back"), object: nil)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "MusicListViewController") as! MusicListViewController
        vc.musicList = musicList
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RandomMusicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2
        let height = width * 112 / 177
        return CGSize(width: width, height: height)
        
    }
}
