//
//  MusicViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/21.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import FSPagerView

class MusicViewController: UIViewController {

    @IBOutlet weak var lblMusic: UILabel!
    @IBOutlet weak var imgMusicTri: UIImageView!
    
    @IBOutlet weak var lblTop: UILabel!
    @IBOutlet weak var imgTopTri: UIImageView!
    
    
    @IBOutlet weak var lblTalent: UILabel!
    @IBOutlet weak var imgTalentTri: UIImageView!
    
    @IBOutlet weak var lblPlaylist: UILabel!
    @IBOutlet weak var imgPlaylistTri: UIImageView!
    
    @IBOutlet weak var musicConView: UIView!
    @IBOutlet weak var topConView: UIView!
    @IBOutlet weak var dropDate: DropDown!
    
    @IBOutlet weak var talentConView: UIView!
    @IBOutlet weak var playlistConView: UIView!
    @IBOutlet weak var musicListConView: UIView!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var topTitleView: UIView!
    
    
    @IBOutlet weak var galeryView: FSPagerView! {
        didSet {
            self.galeryView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
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
        
        
        
        musicConView.isHidden = false
        topConView.isHidden = true
        playlistConView.isHidden = true
        musicListConView.isHidden = true
        talentConView.isHidden = true
        
        btnBack.isHidden = true
        
        galeryView.transformer = FSPagerViewTransformer(type: .overlap)
        galeryView.itemSize = CGSize(width: 140, height: 135)
        galeryView.isInfinite = true
        galeryView.delegate = self
        galeryView.dataSource = self
        
        dropDate.optionArray = ["WEEK", "MONTH", "YEAR"]
        dropDate.selectValue(index: 0)
        dropDate.didSelect(completion: {selectedText, index, id in
            print(selectedText, index, id)
        })
        
        dropDate.delegate = self
        
        topTitleView.isHidden = true
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
        
        musicConView.isHidden = false
        topConView.isHidden = true
        playlistConView.isHidden = true
        musicListConView.isHidden = true
        talentConView.isHidden = true
        btnBack.isHidden = true
        
        lblTitle.text = "Welcome to Dj Boom"
        lblTitle.isHidden = false
        
        topTitleView.isHidden = true
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
        
        musicConView.isHidden = true
        topConView.isHidden = false
        playlistConView.isHidden = true
        musicListConView.isHidden = true
        talentConView.isHidden = true
        btnBack.isHidden = true
        
        lblTitle.isHidden = true
        topTitleView.isHidden = false
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
        
        musicConView.isHidden = true
        topConView.isHidden = true
        playlistConView.isHidden = true
        musicListConView.isHidden = true
        talentConView.isHidden = false
        btnBack.isHidden = true
        
        lblTitle.text = "Talents"
        lblTitle.isHidden = false
        topTitleView.isHidden = true
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
        
        musicConView.isHidden = true
        topConView.isHidden = true
        playlistConView.isHidden = false
        musicListConView.isHidden = true
        talentConView.isHidden = true
        btnBack.isHidden = true
        
        lblTitle.text = "User Playlist"
        lblTitle.isHidden = false
        topTitleView.isHidden = true
    }
    
    @IBAction func onBack(_ sender: Any) {
        let animation = CATransition()
        animation.type = CATransitionType.reveal
        animation.duration = 0.2
        animation.subtype = CATransitionSubtype.fromLeft
        musicListConView.layer.add(animation, forKey: nil)
        musicListConView.isHidden = true
        
        btnBack.isHidden = true
    }
    
}

extension MusicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RandomMusicCollectionViewCell", for: indexPath) as! RandomMusicCollectionViewCell
        cell.conView.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    
}

extension MusicViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let animation = CATransition()
        animation.type = CATransitionType.moveIn
        animation.duration = 0.2
        animation.subtype = CATransitionSubtype.fromRight
        musicListConView.layer.add(animation, forKey: nil)
        musicListConView.isHidden = false
        
        btnBack.isHidden = false
    }
}

extension MusicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width / 2
        let height = width * 112 / 177
        return CGSize(width: width, height: height)
        
    }
}

extension MusicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        if tableView.tag == 100 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "PlaylistViewController") as! PlaylistViewController
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MusicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 100 {
            return 15
        }else if tableView.tag == 4000 {
            return 20
        } else {
            return 3
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 100 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell", for: indexPath) as! PlaylistTableViewCell
            return cell
        } else if tableView.tag == 4000 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
            return cell
        }
        
    }
    
    
}

extension MusicViewController: FSPagerViewDelegate {
    
}

extension MusicViewController: FSPagerViewDataSource {
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 10
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: "picture_placeholder")
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.borderColor = UIColor.white.cgColor
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.masksToBounds = true
        cell.imageView?.layer.cornerRadius = 10
        
        return cell
    }
}

extension MusicViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        dropDate.isSelected ?  dropDate.hideList() : dropDate.showList()
        return false
    }
}
