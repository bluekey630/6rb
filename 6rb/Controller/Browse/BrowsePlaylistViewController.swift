//
//  BrowsePlaylistViewController.swift
//  6rb
//
//  Created by PCH-37 on 2019/8/26.
//  Copyright © 2019 6rb. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class BrowsePlaylistViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var emptyView: UIView!
    
    var playlists: [PlaylistModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        getMyPlaylists()
    }
    
    func configureView() {
        
    }
    
    @objc func getMyPlaylists() {
        ProgressHud.shared.show(view: view, msg: "")
        playlists = []
        tableView.reloadData()
        tableViewHeight.constant = 0
        APIManager.shared.getMyPlaylists(completion: {
            error, response in
            
            ProgressHud.shared.dismiss()
            
            if error != nil {
                CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: error!.localizedDescription)
            } else {
                let res = response as! [String: Any]
                let status = res["status"] as! Int
                if status == 200 {
                    let data = res["data"] as! [Any]
                    for p in data {
                        let playlist = PlaylistModel(dict: p as! [String: Any])
                        self.playlists.append(playlist)
                    }
                    
                    self.tableView.reloadData()
                    self.tableViewHeight.constant = CGFloat(self.playlists.count * 100)
                    self.emptyView.isHidden = (self.playlists.count != 0)
                    
                } else {
                    let message = res["message"] as! String
                    CommonManager.shared.showAlert(viewCtrl: self, title: "Error", msg: message)
                }
            }
        })
    }
    
    @objc func btnMainTapped(sender: UIButton) {
        let index = sender.tag
        let playlist = playlists[index]
        let vc = storyboard?.instantiateViewController(withIdentifier: "MyPlaylistDetailViewController") as! MyPlaylistDetailViewController
        vc.playlist = playlist
//        vc.modalPresentationStyle = .currentContext
//        present(vc, animated: false, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "show-browse-back"), object: nil)
    }
    
    @IBAction func addNewPlaylist(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddPlaylistViewController") as! AddPlaylistViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    func deletePlaylist(index: Int) {
        let playlist = playlists[index]
        let body = [
            "id": playlist.id
        ]
        APIManager.shared.deletePlaylist(body: body, completion: {
            error, response in
            
            print(response)
            self.playlists.remove(at: index)
            self.tableView.reloadData()
            self.tableViewHeight.constant = CGFloat(100 * self.playlists.count)
        })
        
    }
    
    func editPlaylist(index: Int) {
        let playlist = playlists[index]
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditPlaylistViewController") as! EditPlaylistViewController
        vc.delegate = self
        vc.playlist = playlist
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true, completion: nil)
    }
}

extension BrowsePlaylistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistTableViewCell", for: indexPath) as! PlaylistTableViewCell
        let p = playlists[indexPath.row]
        cell.lblTitle.text = p.title
        cell.lblTime.text = CommonManager.shared.secToTime(sec: p.length)
        cell.imgThumbnail.kf.setImage(with: URL(string: p.thumbnail_url)!, placeholder: UIImage(named: "picture_placeholder"))
        
        cell.btnMain.tag = indexPath.row
        cell.btnMain.addTarget(self, action: #selector(btnMainTapped(sender:)), for: .touchUpInside)
        
    
        cell.lblLikeCnt.text = "\(p.like_cnt)"
        cell.lblAddedCnt.text = "\(p.added_cnt)"
        cell.btnPlayedCnt.text = "\(p.play_cnt)"
        cell.btnUserName.text = "\(p.name)"
        
        cell.rightButtons = [MGSwipeButton(title: "", icon: UIImage(named: "ic_edit_white"), backgroundColor: UIColor(red: 0/255, green: 153/255, blue: 255/255, alpha: 1)) {
            (sender: MGSwipeTableCell!)->Bool in
                self.editPlaylist(index: indexPath.row)
                return true
            }, MGSwipeButton(title: "", icon: UIImage(named: "ic_trash"), backgroundColor: .red) {
            (sender: MGSwipeTableCell!)->Bool in
                self.deletePlaylist(index: indexPath.row)
                return true
            }]
        return cell
    }
    
    
}

extension BrowsePlaylistViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
    }
}

extension BrowsePlaylistViewController: PlaylistCreateDelegate {
    func createdPlaylist() {
        self.getMyPlaylists()
    }
}

extension BrowsePlaylistViewController: PlaylistUpdatedDelegate {
    func updatedPlaylist() {
        self.getMyPlaylists()
    }
}
