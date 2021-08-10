//
//  BrowseViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/24.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import FSPagerView

class BrowseViewController: UIViewController {

    @IBOutlet weak var lblHistory: UILabel!
    @IBOutlet weak var imgHistoryTri: UIImageView!
    
    @IBOutlet weak var lblPlaylist: UILabel!
    @IBOutlet weak var imgPlaylistTri: UIImageView!
    
    @IBOutlet weak var lblMySong: UILabel!
    @IBOutlet weak var imgMysongTri: UIImageView!
    
    @IBOutlet weak var historyConView: UIView!
    @IBOutlet weak var playlistConView: UIView!
    @IBOutlet weak var mySongConView: UIView!
    
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
        lblHistory.textColor = UIColor.black
        imgHistoryTri.isHidden = false
        
        lblPlaylist.textColor = UIColor.lightGray
        imgPlaylistTri.isHidden = true
        
        lblMySong.textColor = UIColor.lightGray
        imgMysongTri.isHidden = true
        
        historyConView.isHidden = false
        playlistConView.isHidden = true
        mySongConView.isHidden = true
        
        
        galeryView.transformer = FSPagerViewTransformer(type: .overlap)
        galeryView.itemSize = CGSize(width: 150, height: 120)
        galeryView.delegate = self
        galeryView.dataSource = self
    }

    @IBAction func onHistory(_ sender: Any) {
        lblHistory.textColor = UIColor.black
        imgHistoryTri.isHidden = false
        
        lblPlaylist.textColor = UIColor.lightGray
        imgPlaylistTri.isHidden = true
        
        lblMySong.textColor = UIColor.lightGray
        imgMysongTri.isHidden = true
        
        historyConView.isHidden = false
        playlistConView.isHidden = true
        mySongConView.isHidden = true
    }
    
    @IBAction func onPlaylist(_ sender: Any) {
        lblHistory.textColor = UIColor.lightGray
        imgHistoryTri.isHidden = true
        
        lblPlaylist.textColor = UIColor.black
        imgPlaylistTri.isHidden = false
        
        lblMySong.textColor = UIColor.lightGray
        imgMysongTri.isHidden = true
        
        historyConView.isHidden = true
        playlistConView.isHidden = false
        mySongConView.isHidden = true
    }
    
    @IBAction func onMySong(_ sender: Any) {
        lblHistory.textColor = UIColor.lightGray
        imgHistoryTri.isHidden = true
        
        lblPlaylist.textColor = UIColor.lightGray
        imgPlaylistTri.isHidden = true
        
        lblMySong.textColor = UIColor.black
        imgMysongTri.isHidden = false
        
        historyConView.isHidden = true
        playlistConView.isHidden = true
        mySongConView.isHidden = false
    }
}

extension BrowseViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 100 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
            return cell
        } else if tableView.tag == 200 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell", for: indexPath) as! PlaylistTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SongTableViewCell", for: indexPath) as! SongTableViewCell
            return cell
        }
    }
    
    
}

extension BrowseViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
}

extension BrowseViewController: FSPagerViewDelegate {
    
}

extension BrowseViewController: FSPagerViewDataSource {
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

